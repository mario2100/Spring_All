package com.cmg.java.algorithm.list;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class CircularLinkedNode implements Serializable {

    private int data;
    private CircularLinkedNode next;
    private CircularLinkedNode pre;

    public CircularLinkedNode(int data) {
        this.data = data;
    }
}
