# Tests character row behavior on a string type
describe "String Row Type" do
  tests_row :string

  it "should initialize with correct settings" do
    @row.object.class.should == Formotion::RowType::StringRow
  end

  it "should build cell with textfield" do
    cell = @row.make_cell
    @row.text_field.class.should == UITextField
  end

  # Value
  it "should have no value by default" do
    cell = @row.make_cell
    @row.text_field.text.should == ''
  end

  it "should use custom value" do
    @row.value = 'init value'
    cell = @row.make_cell

    @row.text_field.text.should == 'init value'
  end

  it "should be bound to value of row" do
    @row.value = "first value"
    cell = @row.make_cell

    @row.value = "new value"
    @row.text_field.text.should == 'new value'

    @row.text_field.setText("other value")
    @row.text_field.delegate.on_change(@row.text_field)
    @row.value.should == "other value"
  end

  it "should use custom font" do
    huge_non_default_font = UIFont.boldSystemFontOfSize(20)
    @row.font = huge_non_default_font
    cell = @row.make_cell
    @row.text_field.font.should == huge_non_default_font
  end

  # Placeholder
  it "should have no placeholder by default" do
    cell = @row.make_cell
    @row.text_field.placeholder.should == nil
  end

  it "should use custom placeholder" do
    @row.placeholder = 'placeholder'
    cell = @row.make_cell
    @row.text_field.placeholder.should == 'placeholder'
  end

  # Keyboard
  it "should use default keyboard" do
    cell = @row.make_cell
    @row.text_field.keyboardType.should == UIKeyboardTypeDefault
  end

  # Input Accessory
  it "should have an input accessory" do
    cell = @row.make_cell
    @row.text_field.inputAccessoryView.should != nil
  end

  it "should call the done_action when hitting the 'done' button" do
  end

  describe "on_select" do

    it "should call _on_select" do
      @row.object.instance_variable_set("@called_on_select", false)
      def (@row.object)._on_select(a, b); @called_on_select = true end
      @row.object._on_select(nil, nil)
      @row.object.instance_variable_get("@called_on_select").should == true
    end

    describe "when on_tap callback is set" do
      tests_row :string do |row|
        @on_tap_called = false
        row.instance_variable_set("@text_field", Object.new.tap { |o|
          def o.becomeFirstResponder
          end
        })
        row.on_tap { |row| @on_tap_called = true }
      end

      it "should return true" do
        @row.object._on_select(nil, nil).should == true
      end

      it "should call the callback" do
        @row.object._on_select(nil, nil)
        @on_tap_called.should == true
      end

    end

  end

end
