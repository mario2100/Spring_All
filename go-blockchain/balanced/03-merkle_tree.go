package main

import (
	"bytes"
	"crypto/sha256"
	"fmt"
)

// MerkleTree represent a Merkle tree
type MerkleTree struct {
	RootNode *MerkleNode
}

// MerkleNode represent a Merkle tree node
type MerkleNode struct {
	Left  *MerkleNode
	Right *MerkleNode
	Data  []byte
}

// NewMerkleTree creates a new Merkle tree from a sequence of data
func NewMerkleTree(data [][]byte) *MerkleTree {
	var nodes []MerkleNode

	if len(data)%2 != 0 {
		data = append(data, data[len(data)-1])
	}

	for _, datum := range data {
		node := NewMerkleNode(nil, nil, datum)
		nodes = append(nodes, *node)
	}

	for i := 0; i < len(data)/2; i++ {
		var newLevel []MerkleNode

		for j := 0; j < len(nodes); j += 2 {
			node := NewMerkleNode(&nodes[j], &nodes[j+1], nil)
			newLevel = append(newLevel, *node)
		}
		for _, v := range nodes {
			fmt.Printf("i = %d, %p,%p,%x\n", i, v.Left, v.Right, v.Data)
		}
		fmt.Println()

		nodes = newLevel
		for _, v := range nodes {
			fmt.Printf("i = %d, %p,%p,%x\n", i, v.Left, v.Right, v.Data)
		}
		fmt.Println()
	}
	fmt.Println("--------------\n\n")
	//showMerkleTree(&nodes[0], 0)
	mTree := MerkleTree{&nodes[0]}

	return &mTree
}

func PrintNode(node *MerkleNode) {
	fmt.Printf("%p\n", node)
	if node != nil {
		fmt.Printf("letf[%p],right[%p],data(%x)\n", node.Left, node.Right, node.Data)
		fmt.Printf("check:%t\n", check(node))
	}

}
func check(node *MerkleNode) bool {

	if node.Left == nil {
		return true
	}
	prevHashes := append(node.Left.Data, node.Right.Data...)
	hash32 := sha256.Sum256(prevHashes)
	hash := hash32[:]
	return bytes.Compare(hash, node.Data) == 0
}

// 创建节点
func NewMerkleNode(left, right *MerkleNode, data []byte) *MerkleNode {
	mNode := MerkleNode{}

	if left == nil && right == nil {
		hash := sha256.Sum256(data)
		mNode.Data = hash[:]
	} else {
		prevHashes := append(left.Data, right.Data...)
		hash := sha256.Sum256(prevHashes)
		mNode.Data = hash[:]
	}

	mNode.Left = left
	mNode.Right = right

	return &mNode
}
func ByteSliceEqualBCE(a, b []byte) bool {
	if len(a) != len(b) {
		return false
	}

	if (a == nil) != (b == nil) {
		return false
	}

	b = b[:len(a)]
	for i, v := range a {
		if v != b[i] {
			return false
		}
	}

	return true
}

func showMerkleTree(root *MerkleNode) {

	if root == nil {
		return
	} else {
		PrintNode(root)
	}
	showMerkleTree(root.Left)
	showMerkleTree(root.Right)

}

func main() {
	data := [][]byte{
		[]byte("node1"),
		[]byte("node2"),
		[]byte("node3"),
		[]byte("node4"),
	}

	tree := NewMerkleTree(data)
	showMerkleTree(tree.RootNode)
}
