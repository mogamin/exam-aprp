# -*- coding: utf-8 -*-
require 'logger'
require 'json'

@log = Logger.new(STDOUT)


class Amida

  def initialize(branch_data_file)
    @current = nil
    @deep    = 0
    @amida   = Hash.new
    open(branch_data_file) do |i|
      @amida = JSON.load(i)
    end
  end

  def entered_list
    @amida["entered"]
  end

  def set_start(current = "A")
    @deep    = 0
    @current = current
  end

  def has_next
    (@amida["branches"].size > @deep) ? true : false
  end

  def next
    @amida["branches"][@deep].each { |a, b|
      case @current
      when a
        @current = b
      when b
        @current = a
      end
    }
    @deep += 1
    @current
  end

end



branch_data_list = ["branch_data-1.json","branch_data-2.json","branch_data-3.json"]
branch_data_list.each { |branch_data_file|
  @log.info("--- branch_data_file=#{branch_data_file}")

  amida = Amida.new(branch_data_file)
  amida.entered_list.each { |entered|
    @log.info("* entered=#{entered}")
    amida.set_start(entered)
    while amida.has_next do
      @log.info("  NEXT=" + amida.next)
    end
  }
}



