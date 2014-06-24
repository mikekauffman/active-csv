require 'rspec'
require 'active_csv/base'
require 'csv'

describe ActiveCSV::Base do

  it "can be initialized with nothing" do
    active_csv = ActiveCSV::Base.new
    expect(active_csv).to be_kind_of(ActiveCSV::Base)
  end

  describe "attribute readers" do
    it "defines an attribute reader for every column in the csv" do
      row = CSV::Row.new(["name", "age"], ["joe", "24"])

      active_csv = ActiveCSV::Base.new(row)

      expect(active_csv.name).to eq("joe")
      expect(active_csv.age).to eq("24")
    end

    it "respond_to_missing returns true or false accurately" do
      row = CSV::Row.new(["name", "age"], ["joe", "24"])

      active_csv = ActiveCSV::Base.new(row)

      expect(active_csv.respond_to?(:name)).to eq(true)
      expect(active_csv.respond_to?(:foofoo)).to eq(false)
    end

    it "returns nil if a field is nil" do
      row = CSV::Row.new(["name", "age"], ["joe"])
      active_csv = ActiveCSV::Base.new(row)

      expect(active_csv.age).to eq(nil)
      expect(active_csv.respond_to?(:age)).to eq(true)
      expect(active_csv.respond_to?(:foofoo)).to eq(false)
    end

    it "normalizes the headers into standard ruby format" do
      row = CSV::Row.new(["FIrst   NAme  "], ["Joe"])
      active_csv = ActiveCSV::Base.new(row)

      expect(active_csv.first_name).to eq("Joe")
    end
  end

  describe ".file_path" do
    it "allows you to set the file path to the CSV" do
      klass = Class.new(ActiveCSV::Base) do
        self.file_path = "foo"
      end
      expect(klass.file_path).to eq("foo")
    end
    it ".all returns an array of the Active CSV objects" do
      klass = Class.new(ActiveCSV::Base) do
        self.file_path = "/Users/MikeMac/gSchoolWork/active-csv/spec/fixtures/sample.csv"
      end
      expect(klass.all).to match_array([["id", "first_name"], ["4", "Joe"]])
    end
  end
end