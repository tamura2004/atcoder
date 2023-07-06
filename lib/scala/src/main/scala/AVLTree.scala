class AVLTree(var root: Option[Node] = None) {
  def includes(v: Int): Boolean = {
    root match {
      case Some(node) => node.includes(v)
      case None       => false
    }
  }

  def insert(v: Int): Unit = root match {
    case Some(node) => root = node.insert(v)
    case None       => root = Some(new Node(v))
  }

  def delete(v: Int): Unit = {
    root.map(node => root = node.delete(v))
  }

  def upper(v: Int): Option[Int] = root match {
    case Some(node) => node.upper(v)
    case None       => None
  }

  def lower(v: Int): Option[Int] = root match {
    case Some(node) => node.lower(v)
    case None       => None
  }

  def minNode: Option[Node] = root match {
    case None       => None
    case Some(node) => Some(node.minNode)
  }

  def min: Option[Int] = root match {
    case None       => None
    case Some(node) => Some(node.min)
  }

  def maxNode: Option[Node] = root match {
    case None       => None
    case Some(node) => Some(node.maxNode)
  }

  def max: Option[Int] = root match {
    case None       => None
    case Some(node) => Some(node.max)
  }

  override def toString: String = root match {
    case None       => "()"
    case Some(node) => node.toString

  }
}

class Node(var value: Int) {
  var balance = 0
  var size = 1
  var height = 1
  var left: Option[Node] = None
  var right: Option[Node] = None

  // 存在判定
  def includes(v: Int): Boolean = v match {
    case v if v == value => true
    case v if v < value => {
      left match {
        case None       => false
        case Some(node) => node.includes(v)
      }
    }
    case v if v > value => {
      right match {
        case None       => false
        case Some(node) => node.includes(v)
      }
    }
  }

  // 挿入
  def insert(v: Int): Option[Node] = v match {
    case v if v < value => {
      left match {
        case None       => left = Some(new Node(v))
        case Some(node) => left = node.insert(v)
      }
      Some(this)
    }
    case v if v >= value => {
      right match {
        case None       => right = Some(new Node(v))
        case Some(node) => right = node.insert(v)
      }
      Some(this)
    }
  }

  // 削除
  def delete(v: Int): Option[Node] = {
    if (v == value) delete_equal(v)
    else if (v < value) delete_left(v)
    else delete_right(v)
  }

  // 自身を削除
  def delete_equal(v: Int): Option[Node] = (left, right) match {
    case (None, None) => None
    case (Some(l), None) => left
    case (None, Some(r)) => right
    case (Some(l), Some(r)) => {
      // 左部分木の最大値を持つノードを削除して
      // その値を自身にセット
      l.pop match {
        case (node, maxValue) => {
          left = node
          value = maxValue
          Some(update.reBalance)
        }
      }
    }
  }
  // def delete_equal(v: Int): Option[Node] = left match {
  //   case Some(l) => {
  //     val (x, node) = l.pop
  //     node.left = left
  //     node.right = right
  //     Some(node.update.reBalance)
  //   }
  //   case None => {
  //     right match {
  //       case Some(node) => right
  //       case None       => None
  //     }
  //   }
  // }

  // 左ノード以下を削除
  def delete_left(v: Int): Option[Node] = {
    left.map(node => left = node.delete(v))
    Some(update.reBalance)
    // case Some(node) => {
    //   left = node.delete(v)
    //   Some(this.update.reBalance)
    // }
    // case None => {
    //   left = None
    //   Some(this.update.reBalance)
    // }
  }

  // 右ノード以下を削除
  def delete_right(v: Int): Option[Node] = {
    right.map(node => right = node.delete(v))
    Some(update.reBalance)
    // right
    // case Some(node) => {
    //   right = node.delete(v)
    //   Some(this.update.reBalance)
    // }
    // case None => {
    //   right = None
    //   Some(this.update.reBalance)
    // }
  }

  // v未満の最大値
  def lower(v: Int): Option[Int] = {
    if (value < v) {
      right match {
        case Some(node) => node.lower(v) match {
          case None => Some(value)
          case Some(v) => Some(v)
        }
        case None       => Some(value)
      }
    } else {
      left match {
        case Some(node) => node.lower(v)
        case None       => None
      }
    }
  }

  // vを越える最小値
  def upper(v: Int): Option[Int] = {
    if (v < value) {
      left match {
        case Some(node) => node.upper(v) match {
          case None => Some(value)
          case Some(v) => Some(v)
        }
        case None       => Some(value)
      }
    } else {
      right match {
        case Some(node) => node.upper(v)
        case None       => None
      }
    }
  }

  // 最小のノード
  def minNode: Node = left match {
    case None       => this
    case Some(node) => node.minNode
  }

  // 最小の値
  def min: Int = minNode.value

  // 最大のノード
  def maxNode: Node = right match {
    case None       => this
    case Some(node) => node.maxNode
  }

  // 最大の値
  def max: Int = maxNode.value

  // 最大値を削除して親ノードに自身と値を返す
  def pop: (Option[Node], Int) = right match {
    case None => (None, value)
    case Some(r) => {
      val (node, x) = r.pop
      right = node
      (Some(update.reBalance), x)
    }
  }

  // ノードの状態を更新
  def update: Node = {
    height = scala.math.max(leftHeight, rightHeight) + 1
    balance = leftHeight - rightHeight
    size = leftSize + rightSize + 1
    this
  }

  // 回転によりバランスを保つ
  def reBalance: Node = balance match {
    case v if v >= 2 => {
      if (leftBalance < 0) {
        left.map(node => node.rotateLeft.update)
      }
      rotateLeft.update
    }
    case v if v <= -2 => {
      if (rightBalance > 0) {
        right.map { node =>
          right = Some(node.rotateRight.update)
        }
      }
      rotateLeft.update
    }
    case _ => this
  }

  // 左回転
  def rotateLeft: Node = right match {
    case Some(root) => {
      val ret = root
      right = root.left
      root.left = Some(this)
      root.update
      update
      ret
    }
    case None => this
  }

  // 右回転
  def rotateRight: Node = left match {
    case Some(root) => {
      val ret = root
      left = root.right
      root.right = Some(this)
      root.update
      update
      ret
    }
    case None => this
  }

  def leftHeight: Int = left match {
    case Some(node) => node.height
    case None       => 0
  }

  def rightHeight: Int = right match {
    case Some(node) => node.height
    case None       => 0
  }

  def leftBalance: Int = left match {
    case Some(node) => node.balance
    case None       => 0
  }

  def rightBalance: Int = right match {
    case Some(node) => node.balance
    case None       => 0
  }

  def leftSize: Int = left match {
    case Some(node) => node.size
    case None       => 0
  }

  def rightSize: Int = right match {
    case Some(node) => node.size
    case None       => 0
  }

  override def toString: String = {
    (left, right) match {
      case (None, None)       => value.toString
      case (None, Some(node)) => value.toString ++ " " ++ node.toString
      case (Some(node), None) => node.toString ++ " " ++ value.toString
      case (Some(u), Some(v)) =>
        u.toString ++ " " ++ value.toString ++ " " ++ v.toString
    }
  }
}
