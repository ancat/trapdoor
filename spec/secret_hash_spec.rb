require './lib/core'
require './lib/hash'

RSpec.describe TrapdoorCore do
  context 'after loading' do
    let(:original_env) {{
      "HOME" => "/home/me",
      "PATH" => "/usr/bin:/usr/sbin:/bin:/sbin"
    }}

    let(:in_memory_secrets) {{
      "API_SECRET" => "uQJBAIuya0tHkD",
      "AWS_ACCESS_KEY_ID" => "bogon",
      "AWS_SECRET_KEY" => "bunk"
    }}

    let(:hash_backend) {
      Secret_Hash.new(hash: in_memory_secrets)
    }

    let(:dummy) {
      original_env.tap { |c|
        c.extend(described_class)
      }
    }

    it 'is not enabled until explicitly configured' do
      expect {
        dummy.start_smuggling(backend: hash_backend)
      }.to change {
        dummy.trapdoor_set?
      }.from(false).to(true)
    end

    it 'loads values from the hash we set' do
      expect(hash_backend).to receive(:[]).with("API_SECRET").and_call_original
      expect {
        dummy.start_smuggling(backend: hash_backend)
      }.to change {
        dummy["API_SECRET"]
      }.from(nil).to(in_memory_secrets["API_SECRET"])
    end
  end
end
