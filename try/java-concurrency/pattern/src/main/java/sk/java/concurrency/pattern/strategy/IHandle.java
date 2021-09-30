package sk.java.concurrency.pattern.strategy;

public interface IHandle<T> {

    T handle(T t);
}
