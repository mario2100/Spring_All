package com.example.media;

import android.graphics.Color;
import android.util.TimingLogger;

import androidx.annotation.Nullable;
import androidx.core.graphics.ColorUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.PriorityQueue;

public final class ColorCutQuantizer {
    private static final String LOG_TAG = "ColorCutQuantizer";
    private static final boolean LOG_TIMINGS = false;
    static final int COMPONENT_RED = -3;
    static final int COMPONENT_GREEN = -2;
    static final int COMPONENT_BLUE = -1;
    private static final int QUANTIZE_WORD_WIDTH = 5;
    private static final int QUANTIZE_WORD_MASK = 31;
    final int[] mColors;
    final int[] mHistogram;
    final List<Palette.Swatch> mQuantizedColors;
    @Nullable
    final TimingLogger mTimingLogger = null;
    final Palette.Filter[] mFilters;
    private final float[] mTempHsl = new float[3];
    private static final Comparator<ColorCutQuantizer.Vbox> VBOX_COMPARATOR_VOLUME = new Comparator<ColorCutQuantizer.Vbox>() {
        public int compare(ColorCutQuantizer.Vbox lhs, ColorCutQuantizer.Vbox rhs) {
            return rhs.getVolume() - lhs.getVolume();
        }
    };

    ColorCutQuantizer(int[] pixels, int maxColors, Palette.Filter[] filters) {
        this.mFilters = filters;
        int[] hist = this.mHistogram = new int['耀'];

        int distinctColorCount;
        for (distinctColorCount = 0; distinctColorCount < pixels.length; ++distinctColorCount) {
            int color = quantizeFromRgb888(pixels[distinctColorCount]);
            pixels[distinctColorCount] = color;
            int var10002 = hist[color]++;
        }

        distinctColorCount = 0;

        for (int color = 0; color < hist.length; ++color) {
            if (hist[color] > 0 && this.shouldIgnoreColor(color)) {
                hist[color] = 0;
            }

            if (hist[color] > 0) {
                ++distinctColorCount;
            }
        }

        int[] colors = this.mColors = new int[distinctColorCount];
        int distinctColorIndex = 0;

        for (int color = 0; color < hist.length; ++color) {
            if (hist[color] > 0) {
                colors[distinctColorIndex++] = color;
            }
        }

        if (distinctColorCount <= maxColors) {
            this.mQuantizedColors = new ArrayList();
            int[] var13 = colors;
            int var9 = colors.length;

            for (int var10 = 0; var10 < var9; ++var10) {
                int color = var13[var10];
                this.mQuantizedColors.add(new Palette.Swatch(approximateToRgb888(color), hist[color]));
            }
        } else {
            this.mQuantizedColors = this.quantizePixels(maxColors);
        }

    }

    List<Palette.Swatch> getQuantizedColors() {
        return this.mQuantizedColors;
    }

    private List<Palette.Swatch> quantizePixels(int maxColors) {
        PriorityQueue<ColorCutQuantizer.Vbox> pq = new PriorityQueue(maxColors, VBOX_COMPARATOR_VOLUME);
        pq.offer(new ColorCutQuantizer.Vbox(0, this.mColors.length - 1));
        this.splitBoxes(pq, maxColors);
        return this.generateAverageColors(pq);
    }

    private void splitBoxes(PriorityQueue<ColorCutQuantizer.Vbox> queue, int maxSize) {
        while (true) {
            if (queue.size() < maxSize) {
                ColorCutQuantizer.Vbox vbox = (ColorCutQuantizer.Vbox) queue.poll();
                if (vbox != null && vbox.canSplit()) {
                    queue.offer(vbox.splitBox());
                    queue.offer(vbox);
                    continue;
                }

                return;
            }

            return;
        }
    }

    private List<Palette.Swatch> generateAverageColors(Collection<ColorCutQuantizer.Vbox> vboxes) {
        ArrayList<Palette.Swatch> colors = new ArrayList(vboxes.size());
        Iterator var3 = vboxes.iterator();

        while (var3.hasNext()) {
            ColorCutQuantizer.Vbox vbox = (ColorCutQuantizer.Vbox) var3.next();
            Palette.Swatch swatch = vbox.getAverageColor();
            if (!this.shouldIgnoreColor(swatch)) {
                colors.add(swatch);
            }
        }

        return colors;
    }

    static void modifySignificantOctet(int[] a, int dimension, int lower, int upper) {
        int i;
        int color;
        switch (dimension) {
            case -3:
            default:
                break;
            case -2:
                for (i = lower; i <= upper; ++i) {
                    color = a[i];
                    a[i] = quantizedGreen(color) << 10 | quantizedRed(color) << 5 | quantizedBlue(color);
                }

                return;
            case -1:
                for (i = lower; i <= upper; ++i) {
                    color = a[i];
                    a[i] = quantizedBlue(color) << 10 | quantizedGreen(color) << 5 | quantizedRed(color);
                }
        }

    }

    private boolean shouldIgnoreColor(int color565) {
        int rgb = approximateToRgb888(color565);
        ColorUtils.colorToHSL(rgb, this.mTempHsl);
        return this.shouldIgnoreColor(rgb, this.mTempHsl);
    }

    private boolean shouldIgnoreColor(Palette.Swatch color) {
        return this.shouldIgnoreColor(color.getRgb(), color.getHsl());
    }

    private boolean shouldIgnoreColor(int rgb, float[] hsl) {
        if (this.mFilters != null && this.mFilters.length > 0) {
            int i = 0;

            for (int count = this.mFilters.length; i < count; ++i) {
                if (!this.mFilters[i].isAllowed(rgb, hsl)) {
                    return true;
                }
            }
        }

        return false;
    }

    private static int quantizeFromRgb888(int color) {
        int r = modifyWordWidth(Color.red(color), 8, 5);
        int g = modifyWordWidth(Color.green(color), 8, 5);
        int b = modifyWordWidth(Color.blue(color), 8, 5);
        return r << 10 | g << 5 | b;
    }

    static int approximateToRgb888(int r, int g, int b) {
        return Color.rgb(modifyWordWidth(r, 5, 8), modifyWordWidth(g, 5, 8), modifyWordWidth(b, 5, 8));
    }

    private static int approximateToRgb888(int color) {
        return approximateToRgb888(quantizedRed(color), quantizedGreen(color), quantizedBlue(color));
    }

    static int quantizedRed(int color) {
        return color >> 10 & 31;
    }

    static int quantizedGreen(int color) {
        return color >> 5 & 31;
    }

    static int quantizedBlue(int color) {
        return color & 31;
    }

    private static int modifyWordWidth(int value, int currentWidth, int targetWidth) {
        int newValue;
        if (targetWidth > currentWidth) {
            newValue = value << targetWidth - currentWidth;
        } else {
            newValue = value >> currentWidth - targetWidth;
        }

        return newValue & (1 << targetWidth) - 1;
    }

    private class Vbox {
        private int mLowerIndex;
        private int mUpperIndex;
        private int mPopulation;
        private int mMinRed;
        private int mMaxRed;
        private int mMinGreen;
        private int mMaxGreen;
        private int mMinBlue;
        private int mMaxBlue;

        Vbox(int lowerIndex, int upperIndex) {
            this.mLowerIndex = lowerIndex;
            this.mUpperIndex = upperIndex;
            this.fitBox();
        }

        final int getVolume() {
            return (this.mMaxRed - this.mMinRed + 1) * (this.mMaxGreen - this.mMinGreen + 1) * (this.mMaxBlue - this.mMinBlue + 1);
        }

        final boolean canSplit() {
            return this.getColorCount() > 1;
        }

        final int getColorCount() {
            return 1 + this.mUpperIndex - this.mLowerIndex;
        }

        final void fitBox() {
            int[] colors = ColorCutQuantizer.this.mColors;
            int[] hist = ColorCutQuantizer.this.mHistogram;
            int minBlue = 2147483647;
            int minGreen = 2147483647;
            int minRed = 2147483647;
            int maxBlue = -2147483648;
            int maxGreen = -2147483648;
            int maxRed = -2147483648;
            int count = 0;

            for (int i = this.mLowerIndex; i <= this.mUpperIndex; ++i) {
                int color = colors[i];
                count += hist[color];
                int r = ColorCutQuantizer.quantizedRed(color);
                int g = ColorCutQuantizer.quantizedGreen(color);
                int b = ColorCutQuantizer.quantizedBlue(color);
                if (r > maxRed) {
                    maxRed = r;
                }

                if (r < minRed) {
                    minRed = r;
                }

                if (g > maxGreen) {
                    maxGreen = g;
                }

                if (g < minGreen) {
                    minGreen = g;
                }

                if (b > maxBlue) {
                    maxBlue = b;
                }

                if (b < minBlue) {
                    minBlue = b;
                }
            }

            this.mMinRed = minRed;
            this.mMaxRed = maxRed;
            this.mMinGreen = minGreen;
            this.mMaxGreen = maxGreen;
            this.mMinBlue = minBlue;
            this.mMaxBlue = maxBlue;
            this.mPopulation = count;
        }

        final ColorCutQuantizer.Vbox splitBox() {
            if (!this.canSplit()) {
                throw new IllegalStateException("Can not split a box with only 1 color");
            } else {
                int splitPoint = this.findSplitPoint();
                ColorCutQuantizer.Vbox newBox = ColorCutQuantizer.this.new Vbox(splitPoint + 1, this.mUpperIndex);
                this.mUpperIndex = splitPoint;
                this.fitBox();
                return newBox;
            }
        }

        final int getLongestColorDimension() {
            int redLength = this.mMaxRed - this.mMinRed;
            int greenLength = this.mMaxGreen - this.mMinGreen;
            int blueLength = this.mMaxBlue - this.mMinBlue;
            if (redLength >= greenLength && redLength >= blueLength) {
                return -3;
            } else {
                return greenLength >= redLength && greenLength >= blueLength ? -2 : -1;
            }
        }

        final int findSplitPoint() {
            int longestDimension = this.getLongestColorDimension();
            int[] colors = ColorCutQuantizer.this.mColors;
            int[] hist = ColorCutQuantizer.this.mHistogram;
            ColorCutQuantizer.modifySignificantOctet(colors, longestDimension, this.mLowerIndex, this.mUpperIndex);
            Arrays.sort(colors, this.mLowerIndex, this.mUpperIndex + 1);
            ColorCutQuantizer.modifySignificantOctet(colors, longestDimension, this.mLowerIndex, this.mUpperIndex);
            int midPoint = this.mPopulation / 2;
            int i = this.mLowerIndex;

            for (int count = 0; i <= this.mUpperIndex; ++i) {
                count += hist[colors[i]];
                if (count >= midPoint) {
                    return Math.min(this.mUpperIndex - 1, i);
                }
            }

            return this.mLowerIndex;
        }

        final Palette.Swatch getAverageColor() {
            int[] colors = ColorCutQuantizer.this.mColors;
            int[] hist = ColorCutQuantizer.this.mHistogram;
            int redSum = 0;
            int greenSum = 0;
            int blueSum = 0;
            int totalPopulation = 0;

            int redMean;
            int greenMean;
            int blueMean;
            for (redMean = this.mLowerIndex; redMean <= this.mUpperIndex; ++redMean) {
                greenMean = colors[redMean];
                blueMean = hist[greenMean];
                totalPopulation += blueMean;
                redSum += blueMean * ColorCutQuantizer.quantizedRed(greenMean);
                greenSum += blueMean * ColorCutQuantizer.quantizedGreen(greenMean);
                blueSum += blueMean * ColorCutQuantizer.quantizedBlue(greenMean);
            }

            redMean = Math.round((float) redSum / (float) totalPopulation);
            greenMean = Math.round((float) greenSum / (float) totalPopulation);
            blueMean = Math.round((float) blueSum / (float) totalPopulation);
            return new Palette.Swatch(ColorCutQuantizer.approximateToRgb888(redMean, greenMean, blueMean), totalPopulation);
        }
    }
}
