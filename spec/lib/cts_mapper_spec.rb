require 'spec_helper'

describe CtsMapper do
  it 'has a version number' do
    expect(CtsMapper::VERSION).not_to be nil
  end

  before(:all) do
    @mapper = CtsMapper.new
  end

  describe "#find_by_cite" do
    it "returns an object with info about the standard citation" do
     cite = 'urn:cts:latinLit:phi0448.phi001.perseus-grc1:6'
     res  = @mapper.find_by_cite(cite)
     res.author.should == 'Caes.'
     res.work.should == 'Gall.'
     res.section.should == '6'
    end
  end
end
