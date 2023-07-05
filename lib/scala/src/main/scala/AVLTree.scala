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
    case None => None
    case Some(node) => Some(node.minNode)
  }

  def min: Option[Int] = root match {
    case None => None
    case Some(node) => Some(node.min)
  }

  def maxNode: Option[Node] = root match {
    case None => None
    case Some(node) => Some(node.maxNode)
  }

  def max: Option[Int] = root match {
    case None => None
    case Some(node) => Some(node.max)
  }
}

class Node(val value: Int) {
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
    case v if v == value => Some(this)
    case v if v < value => {
      left match {
        case None       => left = Some(new Node(v))
        case Some(node) => left = node.insert(v)
      }
      Some(this)
    }
    case v if v > value => {
      right match {
        case None       => right = Some(new Node(v))
        case Some(node) => right = node.insert(v)
      }
      Some(this)
    }
  }

  // 削除
  def delete(v: Int): Option[Node] = v match {
    case v if v == value => {
      left match {
        case Some(node) => {
          node.left = left
          node.right = right
          Some(node.update.reBalance)
        }
        case None => {
          right match {
            case Some(node) => right
            case None       => None
          }
        }
      }
    }
    case v if v < value => {
      left match {
        case Some(node) => {
          left = node.delete(v)
          Some(this.update.reBalance)
        }
        case None => {
          left = None
          Some(this.update.reBalance)
        }
      }
    }
    case v if v > value => {
      right match {
        case Some(node) => {
          right = node.delete(v)
          Some(this.update.reBalance)
        }
        case None => {
          right = None
          Some(this.update.reBalance)
        }
      }
    }
  }

  // v未満の最大値
  def lower(v: Int): Option[Int] = v match {
    case v if value < v => {
      right match {
        case Some(node) => {
          node.lower(v) match {
            case Some(node) => Some(scala.math.max(v, value))
            case None       => Some(value)
          }
        }
        case None => Some(value)
      }
    }
    case _ => {
      left match {
        case Some(node) => node.lower(v)
        case None       => None
      }
    }
  }

  // vを越える最小値
  def upper(v: Int): Option[Int] = v match {
    case v if v < value => {
      left match {
        case Some(node) => {
          node.upper(v) match {
            case Some(node) => Some(scala.math.min(v, value))
            case None       => Some(value)
          }
        }
        case None => Some(value)
      }
    }
    case _ => {
      right match {
        case Some(node) => node.upper(v)
        case None       => None
      }
    }
  }

  // 最小のノード
  def minNode: Node = left match {
    case None => this
    case Some(node) => node.minNode
  }

  // 最小の値
  def min: Int = minNode.value

  // 最大のノード
  def maxNode: Node = right match {
    case None => this
    case Some(node) => node.maxNode
  }

  // 最大の値
  def max: Int = maxNode.value

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
}