# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

require 'minitest/autorun'
require 'pry'
require_relative './string_helper'

class TestApp < Minitest::Test

  include StringHelper

  def run_episode(num)
    `ruby geordis-replicator.rb #{num} super-fast`
  end

  def test_reset_exercises
    output = compress(`ruby geordis-replicator.rb --reset-exercises`)
    assert_equal output.last, 'Creating episode-15'
  end

  def test_help_with_no_command_line_arguments
    output = compress(`ruby geordis-replicator.rb`)
    assert_equal output.first, 'Usage'
    assert_equal output.last, 'ruby geordis-replicator.rb 1'
  end

  def test_episode_1_success
    output = compress(run_episode(1))
    assert_equal output.first, "Episode #01: \"CAFFEINE KICKOFF\""
    assert_equal output.last, 'Congratulations! You may now move on to the next episode.'
  end

  def test_remaining_episodes_buggy

    (2..15).each do |num|

      msg = "Testing Episode #{num}"

      temp_print(msg) do
        output = compress(run_episode(num))
        assert_match "Episode ##{pad_with_zero(num)}", output.first
        assert_equal output.last, "Use your newly learned debugging techniques to fix the issue and play the episode again."
      end

    end

  end

end
