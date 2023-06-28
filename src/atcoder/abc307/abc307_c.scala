object Answer { def is(x:String) = {out.write(x); out.newLine; out.flush}
val in = new java.io.BufferedReader(new java.io.InputStreamReader(System.in))
val out = new java.io.BufferedWriter(new java.io.OutputStreamWriter(System.out))
def nst = new java.util.StringTokenizer(in.readLine); private var st = nst;
def nex = {if(!st.hasMoreTokens)st=nst;st.nextToken}
def nexln = in.readLine; def is(x:Any):Unit=is(x.toString)}
import Answer._, math._, collection.{mutable=>M,_}

object Main extends App {
  val Seq(a,b,c) = (1 to 3).map { _ =>
    val h, w = nex.toInt
    val s = Array.fill(h)(nex.toCharArray)
    val wk = for {
      y <- 0 until h
      x <- 0 until w
      if s(y)(x) == '#'
    } yield {
      (y, x)
    }
    normalize(wk.toSet)
  }

  val ans = (-20 to 20).exists { y =>
    (-20 to 20).exists { x =>
      normalize(move(a, y, x) | b) == c
    }
  }

  Answer is (if(ans) "Yes" else "No")

  def normalize(set: Set[(Int,Int)]) = {
    val (i, j) = set.min
    set.map { case (y, x) => (y - i, x - j) }.toSet
  }

  def move(set: Set[(Int,Int)], i: Int, j: Int) = {
    set.map { case(y, x) => (y + i, x + j) }.toSet
  }
}
