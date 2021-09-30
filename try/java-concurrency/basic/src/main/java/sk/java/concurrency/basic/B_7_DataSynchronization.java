package sk.java.concurrency.basic;

/**
 * 数据同步
 */
public class B_7_DataSynchronization {

    static class WindowRunnable implements Runnable {
        int index = 1;
        int max = 500;

        @Override
        public void run() {
            while (index <= max) {
                System.out.println(Thread.currentThread().getName() + " 拿的号码是：" +
                        (index++));
            }
        }
    }

    //数据一致性问题
    public static void main(String[] args) {
        final WindowRunnable task = new WindowRunnable();
        Thread window1 = new Thread(task, "一号窗口");
        Thread window2 = new Thread(task, "二号窗口");
        Thread window3 = new Thread(task, "三号窗口");
        Thread window4 = new Thread(task, "四号窗口");
        window1.start();
        window2.start();
        window3.start();
        window4.start();
    }

    //synchronized 锁机制 互斥访问
    //monitor enter exit 两个指令
    //严格遵守happen-before原则 指令成对出现
    //monitor 计数器 为 0




}

