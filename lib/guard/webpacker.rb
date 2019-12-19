# frozen_string_literal: true

require 'guard/compat/plugin'
require 'timeout'

module Guard
  class WebPacker < Plugin
    DEFAULT_PATH = 'bin'
    WEBPACK_DEV_SERVER = 'webpack-dev-server'
    WEBPACK = 'webpack'
    DEFAULT_SIGNAL = :TERM

    def initialize(options = {})
      super

      @pid = nil
      @path = options[:path] || DEFAULT_PATH
      @bin = options[:bin] || WEBPACK_DEV_SERVER
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
    end

    def start
      unless File.exist?(File.join(@path, @bin))
        Guard::Compat::UI.info "[Guard::WebPacker::Error] Could not find #{@bin} at #{@path}."
        return false
      end

      Guard::Compat::UI.info "[Guard::WebPacker] Starting up #{@bin} ..."
      Guard::Compat::UI.info cmd

      # launch webpack-dev-server or webpack
      @pid = spawn({}, cmd)
    end

    def stop
      return unless @pid

      Guard::Compat::UI.info "[Guard::WebPacker] Stopping #{@bin} ..."
      ::Process.kill @stop_signal, @pid
      begin
        Timeout.timeout(15) do
          ::Process.wait @pid
        end
      rescue Timeout::Error
        Guard::Compat::UI.info "[Guard::WebPacker] Sending SIGKILL to #{@bin}, as it\'s taking too long to shutdown."
        ::Process.kill :KILL, @pid
        ::Process.wait @pid
      end
      @pid = nil
      Guard::Compat::UI.info "[Guard::WebPacker] Stopped process #{@bin} ..."
    end

    # Called on Ctrl-Z signal
    def reload
      Guard::Compat::UI.info "[Guard::WebPacker] Restarting #{@bin} ..."
      restart
    end

    # Called on Ctrl-/ signal
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_changes(_)
      restart
    end

    def restart
      stop
      start
    end

    private

    def cmd
      command = ["bundle exec #{@path}/#{@bin}"]

      if @bin == WEBPACK
        command << '--watch'                    if @options[:watch]
        command << '--colors'                   if @options[:colors]
        command << '--progress'                 if @options[:progress]
        command << '--progress'                 if @options[:progress]
        command << "--mode #{@options[:mode]}"  if @options[:mode]
      end

      command.join(' ')
    end
  end
end
