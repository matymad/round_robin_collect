# frozen_string_literal: true

require 'json'
require './round_robin_collect'

empty_hash = { "logs": [], "content": [], "myad": [] }

RSpec.describe RoundRobinCollect do
  it 'Should raise error if the first parameter is not a hash' do
    hash = [1, 2, 3]
    message = /.*[Hash parameter expected. Got #{hash.class}].*/
    expect { RoundRobinCollect.collect(hash, 4, 'token') }.to(
      raise_error.with_message(message)
    )
  end

  it 'Should raise error if the second parameter is not an integer' do
    max_items = '5'
    message = /.*[Integer parameter expected. Got #{max_items.class}].*/
    expect { RoundRobinCollect.collect(empty_hash, max_items, 'token') }.to(
      raise_error.with_message(message)
    )
  end

  it 'Should raise error if the third parameter is not a String' do
    token = :token
    message = /.*[String parameter expected. Got #{token.class}].*/
    expect { RoundRobinCollect.collect(empty_hash, 4, token) }.to(
      raise_error.with_message(message)
    )
  end

  it 'Should return an array' do
    arr = RoundRobinCollect.collect(empty_hash, 4, 'token')
    expect(arr).to eq([])
  end

  it 'Should return [345048] in case of example_1' do
    file = File.read('example_1.json')
    hash = JSON.parse(file)
    arr = RoundRobinCollect.collect(hash, 4, 'token').map(&:to_i)
    expect(arr).to eq([345_048])
  end

  it 'Should return [790952, 103678, 788138, 802358] in case of example_2' do
    file = File.read('example_2.json')
    hash = JSON.parse(file)
    arr = RoundRobinCollect.collect(hash, 4, 'token').map(&:to_i)
    expect(arr).to eq([790_952, 103_678, 788_138, 802_358])
  end

  it 'Should return [103678, 790952, 802358, 788138] in case of example_3' do
    file = File.read('example_3.json')
    hash = JSON.parse(file)
    arr = RoundRobinCollect.collect(hash, 4, 'token').map(&:to_i)
    expect(arr).to eq([103_678, 790_952, 802_358, 788_138])
  end

  it 'Should return [790952, 103678, 802358, 562873] in case of example_4' do
    file = File.read('example_4.json')
    hash = JSON.parse(file)
    arr = RoundRobinCollect.collect(hash, 4, 'token').map(&:to_i)
    expect(arr).to eq([790_952, 103_678, 802_358, 562_873])
  end
end
