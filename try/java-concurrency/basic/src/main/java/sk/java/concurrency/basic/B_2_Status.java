package sk.java.concurrency.basic;

/**
 * thread status
 * 线程状态与生命周期
 */
public class B_2_Status {

    //start  new status

    //------ active  status -------

    //scheduled by CPU   runnable -> running

    //yield/schedule swap running -> runnable

    //------ active  status -------


    //suspend sleep wait  active -> blocked

    //resume/notify/notifyAll blocked -> active


    //stop active -> terminated

    // stop blocked -> terminated

    //thread life cycle end和线程不能重复调用start方法

    //创建它的线程即是父线程

    //线程组 与 优先级

    //虚拟机栈参数 stackSize


}
