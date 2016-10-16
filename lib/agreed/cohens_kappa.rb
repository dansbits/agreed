module Agreed
  class CohensKappa

    attr_reader :contingency_table

    def initialize(rater1, rater2)
      raise 'ExpectedArray' unless rater1.class ==  Array && rater2.class == Array

      @labels = Daru::DataFrame.new({rater1: rater1, rater2: rater2})
      @categories = (rater1 + rater2).uniq.sort

      build_contingency_table
    end

    def kappa
      (self.p - self.p_e) / (1 - self.p_e)
    end

    def p
      observed_agreements = 0
      @categories.each { |cat| observed_agreements += @contingency_table[cat][cat] }

      observed_agreements.to_f / @labels.size.to_f
    end

    def p_e
      numerator_parts = (0..(@categories.count - 1)).to_a.map do |index|
        rater1_count = @contingency_table.at(index).sum
        rater2_count = @contingency_table.row_at(index).sum

        (rater1_count * rater2_count).to_f / @labels[:rater1].count.to_f
      end

      numerator = Daru::Vector.new(numerator_parts).sum

      numerator.to_f / @labels.size.to_f
    end

    private

    def build_contingency_table
      columns = {}
      @categories.each { |cat| columns[cat] = Array.new(@categories.count, 0) }

      @contingency_table = Daru::DataFrame.new(columns, index: @categories)
      @labels.each_row { |row| @contingency_table[row[:rater1]][row[:rater2]] += 1 }
    end

  end

end