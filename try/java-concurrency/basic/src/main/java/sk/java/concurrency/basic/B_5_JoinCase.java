package sk.java.concurrency.basic;

import sk.java.concurrency.basic.joincase.FlightQueryTask;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * join 方法使用case
 */
public class B_5_JoinCase {
    //串型任务局部并行处理

    //航空公司
    static List<String> flightList = Arrays.asList("CSA", "HNA", "CEA");

    static List<String> search(String from, String destination) throws InterruptedException {
        List<String> result = new ArrayList<>();

        List<FlightQueryTask> tasks = flightList.stream().map(f -> creatTask(f, from, destination))
                .collect(Collectors.toList());

        tasks.forEach(Thread::start);

        for (FlightQueryTask task : tasks) {
            task.join();
        }

        tasks.stream().map(FlightQueryTask::get).forEach(result::addAll);

        return result;
    }

    static FlightQueryTask creatTask(String f, String from, String destination) {
        return new FlightQueryTask(f, from, destination);
    }

    public static void main(String[] args) throws InterruptedException {
        List<String> results = search("SH", "BJ");
        results.forEach(System.out::println);
    }

}
