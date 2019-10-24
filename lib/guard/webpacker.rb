# frozen_string_literal: true

require 'guard/compat/plugin'
require 'timeout'

module Guard
  class WebPacker < Plugin
    DEFAULT_BIN = 'webpack-dev-server'
    DEFAULT_SIGNAL = :TERM

    def initialize(options = {})
      @pid = nil
      @bin = options[:bin] || DEFAULT_BIN
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
      super
    end

    def start
      stop
      Guard::Compat::UI.info "Starting up #{@bin} ..."
      Guard::Compat::UI.info cmd

      # launch webpack-dev-server or webpack
      @pid = spawn({}, cmd)
    end

    def stop
      return unless @pid

      Guard::Compat::UI.info "Stopping #{@bin} ..."
      ::Process.kill @stop_signal, @pid
      begin
        Timeout.timeout(15) do
          ::Process.wait @pid
        end
      rescue Timeout::Error
        Guard::Compat::UI.info "Sending SIGKILL to #{@bin}, as it\'s taking too long to shutdown."
        ::Process.kill :KILL, @pid
        ::Process.wait @pid
      end
      Guard::Compat::UI.info "Stopped process #{@bin} ..."
    end

    # Called on Ctrl-Z signal
    def reload
      Guard::Compat::UI.info "Restarting #{@bin} ..."
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
      command = ["bundle exec bin/#{@bin}"]

      if @bin != DEFAULT_BIN
        command << '--watch'           if @options[:watch]
        command << '--colors'          if @options[:colors]
        command << '--progress'        if @options[:progress]
      end

      command.join(' ')
    end
  end
end
