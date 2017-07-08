# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

require 'io/console'
require 'json'
require 'fileutils'
require_relative './string_helper'
require_relative './display'
require_relative './generator'
require_relative './episode'
require_relative './recipe'
require_relative './validator'

class App

  include StringHelper

  attr_reader :episode, :enterprise

  def initialize

    command = ARGV.first
    Display.help_and_exit unless command

    if command.slice(0, 2) == '--'
      Generator.invoke(command)
    else
      episode_number = pad_with_zero(command)
      play(episode_number)
    end

  end

  def play(episode_number)

    episode = Episode.new(episode_number)
    load_episode_files(episode)
    display = Display.new(episode)
    display.episode_title_and_setup
    enterprise = Enterprise.new
    display.enterprise_image
    display.star_saying_replicator_command
    display.press_any_key
    display.replicator_whirling_effect
    enterprise.replicator.replicate(episode.recipe)
    display.star_anticipating_replicator_creation
    glass = enterprise.replicator.plate.contents.first
    Validator.new(glass, episode.recipe) if glass
    display.star_responding_to_replicator_creation(glass)

  end

  def load_episode_files(episode)
    Dir.glob("episode-#{episode.number}/*.rb").each { |file| require "./#{file}" }
  end

end
