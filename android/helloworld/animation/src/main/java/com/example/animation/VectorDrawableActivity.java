package com.example.animation;

import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;

import androidx.appcompat.app.AppCompatActivity;

/**
 * 矢量动画
 */
public class VectorDrawableActivity extends AppCompatActivity implements OnClickListener {
    private ImageView iv_vector; // 声明一个图像视图对象

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vector_drawable);
        // 从布局文件中获取名叫iv_vector的图像视图
        iv_vector = findViewById(R.id.iv_vector);
        findViewById(R.id.btn_vector_heart).setOnClickListener(this);
        findViewById(R.id.btn_vector_face).setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if (v.getId() == R.id.btn_vector_heart) {
            // 设置图像视图的图像资源为心形矢量图形
            iv_vector.setImageResource(R.drawable.vector_heart);
        } else if (v.getId() == R.id.btn_vector_face) {
            // 设置图像视图的图像资源为笑脸矢量图形
            iv_vector.setImageResource(R.drawable.vector_face);
        }
    }

}
