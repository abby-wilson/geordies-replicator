# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

module StringHelper

  def word_wrap(str, width = 60)
    str.gsub!(/(.{1,#{width}})(\s+|\Z)/, "\\1\n ").rstrip
  end

  def temp_print(str)
    print str
    yield
    print "\b" * str.size
    print ' '  * str.size
    print "\b" * str.size
  end

  def pad_with_zero(num)
    num.to_s.size == 1 ? "0#{num}" : num
  end

  def compress(output)
    output.split("\n").delete_if(&:empty?).map(&:strip)
  end

end
