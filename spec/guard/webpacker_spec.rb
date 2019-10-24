# frozen_string_literal: true

RSpec.describe Guard::WebPacker, exclude_stubs: [Guard::Plugin] do
  describe 'start' do
    it 'should works' do
      obj = Guard::WebPacker.new
      expect(obj.send(:cmd)).to eq 'bundle exec bin/webpack-dev-server'
    end

    it 'accepts :bin option' do
      obj = Guard::WebPacker.new bin: 'webpack'
      expect(obj.send(:cmd)).to eq 'bundle exec bin/webpack'
    end

    context 'with webpack-dev-server' do
      it 'not accepts :watch option with bin webpack' do
        obj = Guard::WebPacker.new watch: true
        cmd = obj.send(:cmd)
        expect(cmd).to eq 'bundle exec bin/webpack-dev-server'
      end

      it 'not accepts :colors option with bin webpack' do
        obj = Guard::WebPacker.new colors: true
        cmd = obj.send(:cmd)
        expect(cmd).to eq 'bundle exec bin/webpack-dev-server'
      end

      it 'not accepts :progress option with bin webpack' do
        obj = Guard::WebPacker.new progress: true
        cmd = obj.send(:cmd)
        expect(cmd).to eq 'bundle exec bin/webpack-dev-server'
      end
    end

    context 'with webpack' do
      it 'accepts :watch option with bin webpack' do
        obj = Guard::WebPacker.new bin: 'webpack', watch: true
        cmd = obj.send(:cmd)
        expect(cmd).to include 'bundle exec bin/webpack'
        expect(cmd).to include '--watch'
      end

      it 'accepts :colors option with bin webpack' do
        obj = Guard::WebPacker.new bin: 'webpack', colors: true
        cmd = obj.send(:cmd)
        expect(cmd).to include 'bundle exec bin/webpack'
        expect(cmd).to include '--colors'
      end

      it 'accepts :progress option with bin webpack' do
        obj = Guard::WebPacker.new bin: 'webpack', progress: true
        cmd = obj.send(:cmd)
        expect(cmd).to include 'bundle exec bin/webpack'
        expect(cmd).to include '--progress'
      end
    end
  end
end
