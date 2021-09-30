package sk.java.concurrency.basic.joincase;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;

/**
 * 查询任务
 */
public class FlightQueryTask extends Thread implements FlightQuery {
    @Override
    public List<String> get() {
        return this.flightList;
    }

    private String from;
    private String destination;

    private List<String> flightList = new ArrayList<>();

    public FlightQueryTask(String airline, String from, String destination) {
        super(airline);
        this.from = from;
        this.destination = destination;
    }

    @Override
    public void run() {
        System.out.printf("%s query from %s to %s   ", getName(), from, destination);
        int randomInt = ThreadLocalRandom.current().nextInt(5);
        try {
            TimeUnit.SECONDS.sleep(randomInt);
            this.flightList.add(getName() + "-" + randomInt);
            System.out.printf("The fight: %s query succeed  ", getName());
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
}
