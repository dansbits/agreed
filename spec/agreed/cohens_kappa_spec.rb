require 'spec_helper'

describe Agreed::CohensKappa do

  describe ".new" do

    it "raises an error when the inputs are not arrays" do
      rater1 = [1,2,3]
      rater2 = { cats: 1, dogs: 2}
      expect{ Agreed::CohensKappa.new(rater1, rater2) }.to raise_error 'ExpectedArray'
    end

    it "creates the contingency table" do
      rater1 = ['yes','no','no','yes','yes']
      rater2 = ['no','yes','no','yes','yes']

      kappa = Agreed::CohensKappa.new(rater1, rater2)

      table = kappa.contingency_table

      expect(table['yes']['yes']).to eq 2
      expect(table['no']['no']).to eq 1
      expect(table['yes']['no']).to eq 1
      expect(table['no']['yes']).to eq 1
    end

    context "when a label is only present for one rater" do

      let(:rater1) { ['yes','no','no','yes','maybe'] }
      let(:rater2) { ['no','yes','no','yes','yes'] }

      it "creates a row and column for the label" do
        kappa = Agreed::CohensKappa.new(rater1, rater2)

        expect(kappa.contingency_table.vectors.to_a).to eq ['maybe','no','yes']
        expect(kappa.contingency_table.index.to_a).to eq ['maybe','no','yes']
      end

    end
  end

  describe "#p" do

    it "gets the proportion of observations with agreement" do
      rater1 = ['yes','no','no','yes','yes']
      rater2 = ['no','yes','no','yes','yes']

      kappa = Agreed::CohensKappa.new(rater1, rater2)

      expect(kappa.p).to eq 0.6
    end

  end

  describe "#p_e" do

    it "gets the proportion of agreements anticipated by chance" do
      rater1 = ['yes','no','no','yes','yes']
      rater2 = ['no','yes','no','yes','yes']

      kappa = Agreed::CohensKappa.new(rater1, rater2)

      yes_proportion = (3 * 3).to_f / 5.to_f
      no_proportion = (2 * 2).to_f / 5.to_f

      expect(kappa.p_e).to eq (yes_proportion + no_proportion).to_f / 5.to_f
    end

  end

  describe "#kappa" do

    it "calculates the kappa score" do
      rater1 = ['yes','no','no','yes','yes']
      rater2 = ['no','yes','no','yes','yes']

      kappa = Agreed::CohensKappa.new(rater1, rater2)

      expect(kappa.kappa).to eq (kappa.p - kappa.p_e).to_f / (1 - kappa.p_e).to_f
    end

  end

end