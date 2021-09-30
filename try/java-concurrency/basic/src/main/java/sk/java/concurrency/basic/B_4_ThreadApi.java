package sk.java.concurrency.basic;

import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * 线程的几个方法
 */
public class B_4_ThreadApi {

    //functions

    //TimeUnit 代替Thread Sleep

    //yield 提示调度器我愿意放弃CPU调用 只是一个提示 并一定满足

    //一个线程sleep另一个线程调用interrupt会捕获到中断 yield 不会

    //优先级 忙时有区别 闲暇时没什么区别 1到10 派生线程优先级与父级一样

    //interrupt 打断阻塞

//    public static void main(String[] args) throws InterruptedException {
//        Thread thread = new Thread(() -> {
//            try {
//                TimeUnit.MINUTES.sleep(1);
//            } catch (InterruptedException e) {
//                System.out.println("I am interrupted");
//                e.printStackTrace();
//            }
//        });
//        thread.start();
//        TimeUnit.MILLISECONDS.sleep(2);
//        thread.interrupt();
//    }

//    public static void main(String[] args) throws InterruptedException {
//        Thread thread = new Thread() {
//            @Override
//            public void run() {
//                while (true) {
//
//                }
//            }
//        };
//        thread.setDaemon(true);
//        thread.start();
//        TimeUnit.MILLISECONDS.sleep(2);
//        System.out.println("isInterrupted 1:" + thread.isInterrupted());
//        thread.interrupt();
//        TimeUnit.MILLISECONDS.sleep(2);
//        System.out.println("isInterrupted 2:" + thread.isInterrupted());
//    }

//    public static void main(String[] args) throws InterruptedException {
//        Thread thread = new Thread() {
//            @Override
//            public void run() {
//                while (true) {
//                    try {
//                        TimeUnit.MINUTES.sleep(1);
//                    } catch (InterruptedException e) {
//                        System.out.println("I am interrupted");
//                        //捕获到异常 清理flag clear flag
//                        System.out.println("isInterrupted exception:" + isInterrupted());
//                    }
//                }
//            }
//        };
//        thread.setDaemon(true);
//        thread.start();
//        TimeUnit.MILLISECONDS.sleep(2);
//        System.out.println("isInterrupted 1:" + thread.isInterrupted());
//        thread.interrupt();
//        TimeUnit.MILLISECONDS.sleep(2);
//        System.out.println("isInterrupted 2:" + thread.isInterrupted());
//    }

//

    //join 方法
    public static void main(String[] args) throws InterruptedException {

        List<Thread> threads = IntStream.range(1, 3).
                mapToObj(B_4_ThreadApi::create).collect(Collectors.toList());

        threads.forEach(Thread::start);

        for (Thread thread : threads) {
            thread.join();
        }

        //主线程调用
        for (int i = 0; i < 10; i++) {
            System.out.println(Thread.currentThread().getName() + " %" + i);
        }
    }

    public static Thread create(int seq) {
        return new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                System.out.println(Thread.currentThread().getName() + " %" + i);
            }
            shortSleep();
        });
    }

    private static void shortSleep() {
        try {
            TimeUnit.SECONDS.sleep(1);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
