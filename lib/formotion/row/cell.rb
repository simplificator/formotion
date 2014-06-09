module Formotion
  class RowCellBuilder
    class Cell < UITableViewCell
      def layoutSubviews
        super
        frame = self.textLabel.frame
        frame.origin.x = 15.0
        frame.origin.y = 10.0

        self.textLabel.frame = frame
      end
    end
  end
end
