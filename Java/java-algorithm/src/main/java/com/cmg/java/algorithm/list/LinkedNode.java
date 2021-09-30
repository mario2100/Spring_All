package com.cmg.java.algorithm.list;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class LinkedNode implements Serializable {
    private int data;
    private LinkedNode next;

    public LinkedNode(int data) {
        this.data = data;
    }
}
