# -*- coding: utf-8 -*-
require 'logger'
require 'json'

@log = Logger.new(STDOUT)

def walk_in_amida(amida)
  amida["entered"].each { |current|
    @log.info("* entered=#{current}")
    amida["branches"].each_with_index { |swap, deep|
      next_to = current
      swap.each { |a, b|
        case current
        when a
          next_to = b
        when b
          next_to = a
        end
        break if current != next_to
      }
      @log.info(" deep=#{deep},position=#{current}->#{next_to}")
      current = next_to
    }
  }
end

branch_data_list = ["branch_data-1.json","branch_data-2.json","branch_data-3.json"]
branch_data_list.each { |branch_data_file|
  open(branch_data_file) do |i|
    @log.info("--- branch_data_file=#{branch_data_file}")
    walk_in_amida(JSON.load(i))
  end
}



