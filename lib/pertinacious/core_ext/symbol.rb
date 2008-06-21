class Symbol
  include File::Extension
  include File::Pathize
end


# -- --- Specs --- -- #

describe Symbol do
  
  describe "extensions" do
    it "should concatenate an extension" do
      :foo.rb.should == "foo.rb"
    end

    it "should not screw with missing methods" do
      lambda {:foo.bar}.should raise_error(NoMethodError)
    end
  end
  
  describe "paths" do
    it "should concatenate a path" do
      (:foo / :bar).should == File.join('foo', 'bar')
    end
  end
  
end