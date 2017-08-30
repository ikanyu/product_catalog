class ChildrenReassignmentService
  def initialize(category)
    @category = category
  end

  def perform
    move_sub_nodes
  end

  private

  def move_sub_nodes
    if has_parent_and_child?
      move_children_to_immediate_parent
    else
      move_children_to_root
    end
  end

  def has_parent_and_child?
    @category.child? && !@category.leaf?
  end

  def move_children_to_immediate_parent
    @category.children.each do |child|
      child.move_to_child_of(@category.parent)
      @category.parent.reload
    end
  end

  def move_children_to_root
    @category.children.each do |child|
      child.move_to_root
      child.reload
    end
  end
end
