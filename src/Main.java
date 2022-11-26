import java.util.Scanner;
import java.util.PriorityQueue;

class Main{
	public static void main(String[] args){
		// Scanner sc = new Scanner(System.in);
		// int n = sc.nextInt();
    // int m = sc.nextInt();

		PriorityQueue<Node> pq = new PriorityQueue<Node>();

    pq.add(new Node(1, 40l));
    pq.add(new Node(2, 30l));
    pq.add(new Node(3, 20l));
    pq.add(new Node(4, 50l));
    pq.add(new Node(5, 60l));

		for(int i = 0; i < 5; i++) {
		  System.out.println(pq.poll());
    }
	}
}

class Node implements Comparable<Node> {
  private Integer id;
  private Long cost;

  public Node(Integer id, Long cost) {
    this.id = id;
    this.cost = cost;
  }

  public Integer getId() {
    return this.id;
  }

  public Long getCost() {
    return this.cost;
  }

  @Override
  public String toString() {
    return "id = " + id + ", cost = " + cost;
  }

  @Override
  public int compareTo(Node other) {
    return Long.compare(this.cost, other.getCost());
  }
}