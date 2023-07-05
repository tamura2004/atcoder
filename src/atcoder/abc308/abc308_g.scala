class Node(val value: Int) {
  var left : Option[Node] = None
  var right : Option[Node] = None

  def includes(v: Int): Boolean = v match {
    case v if v == value => true
    case v if v < value => {
      left match {
        case None => false
        case Some(node) => node.includes(v)
      }
    }
    case v if v > value => {
      right match {
        case None => false
        case Some(node) => node.includes(v)
      }
    }
  }

  def insert(v: Int): Option[Node] = v match {
    case v if v == value => Some(this)
    case v if v < value => {
      left match {
        case None => left = Some(new Node(v))
        case Some(node) => left = node.insert(v)
      }
      Some(this)
    }
    case v if v > value => {
      right match {
        case None => right = Some(new Node(v))
        case Some(node) => right = node.insert(v)
      }
      Some(this)
    }
  }
}

object Main extends App {
  val node = new Node(10)
  node.insert(5)
  node.insert(15)
  println(node)
  println(node.right)
  println(node.left)

}