package sk.java.concurrency.basic;

import java.util.concurrent.TimeUnit;

/**
 * 初识线程
 */
public class B_1_FirstTouch {

    static void browseNews() throws InterruptedException {
        for (; ; ) {
            TimeUnit.SECONDS.sleep(3);
            System.out.println("take a look,what happened on the earth...");
        }
    }

    static void listenMusic() throws InterruptedException {
        for (; ; ) {
            TimeUnit.SECONDS.sleep(1);
            System.out.println("Jay Chou jay chou chou....");
        }
    }

    public static void main(String[] args) throws InterruptedException {

        new Thread() {
            @Override
            public void run() {
                try {
                    listenMusic();
                } catch (Exception e) {

                }
            }
        }.start();
        browseNews();
    }
}
