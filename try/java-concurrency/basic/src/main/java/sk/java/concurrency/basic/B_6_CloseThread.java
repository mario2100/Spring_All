package sk.java.concurrency.basic;

import java.util.concurrent.TimeUnit;

/**
 * 关闭线程
 */
public class B_6_CloseThread {

    //stop禁用 不会释放monitor 的锁

    //正常关闭 生命周期结束
    //捕获到中断信号 关闭

//    public static void main(String[] args) throws InterruptedException {
//        Thread thread = new Thread() {
//            @Override
//            public void run() {
//                System.out.println("I will start working");
//                super.run();
//                while (!isInterrupted()) {
//                    //可中断方法 sleep wait
//                    //working
//                }
//                System.out.println("I am off work,exiting task");
//            }
//        };
//        thread.start();
//        TimeUnit.SECONDS.sleep(5);
//        System.out.println("main thread will exit");
//        thread.interrupt();
//    }


    //使用volatile开关控制

    //检查异常退出

    //进程假死

    //jvisualvm


}
