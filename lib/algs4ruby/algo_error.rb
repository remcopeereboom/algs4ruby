module Algs4Ruby
  # AlgoError
  #
  # A wrapper for library specific errors. This allows easy capture of all
  # library specific errors. The library may still throw general errors for
  # non-library specific problems (e.g. NoMethodError or ArgumentError).
  class AlgoError < StandardError; end

  # StackEmptyError
  #
  # A StackEmptyError indicates that an operation failed because it was called
  # on an empty stack.
  class StackEmptyError < AlgoError; end

  # QueueEmptyError
  #
  # A QueueEmptyError indicates that an operation failed because it was called
  # on an empty queue.
  class QueueEmptyError < AlgoError; end

  # PriorityQueueEmptyError
  #
  # A PriorityQueueEmptyError indicates that an operation failed because it was
  # called on an empty queue.
  class PriorityQueueEmptyError < AlgoError; end

  # NotBipartiteError
  #
  # A NotBipartiteError indicates that an operation failed because it was
  # called on an undirected graph that was not bipartite.
  class NotBipartiteError < AlgoError; end
end
