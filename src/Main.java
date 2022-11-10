import java.util.Scanner;
import java.util.PriorityQueue;
import java.util.Comparator;

class Main{
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
    int m = sc.nextInt();

		PriorityQueue<Integer> pq = new PriorityQueue<Integer>(Comparator.reverseOrder());

		for(int i = 0; i < n; i++) {
			pq.add(sc.nextInt());
    }
		for(int i = 0; i < m; i++) {
			pq.add(pq.poll() / 2);
    }
		System.out.println(pq.stream().mapToLong(i->i).sum());
    sc.close();
	}
}
