require "spec_helper"

RSpec.describe Tickets do
  it "has a version number" do
    expect(Tickets::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
