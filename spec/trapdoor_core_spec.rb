require './lib/core'

RSpec.describe TrapdoorCore do
  context 'when loading' do
    let(:dummy) { Hash.new.tap { |c| c.extend(described_class) } }

    it 'is not enabled until explicitly configured' do
      expect {
        dummy.start_smuggling(backend: nil)
      }.to change {
        dummy.trapdoor_set?
      }.from(false).to(true)
    end

    it 'modifies hash related methods after being configured' do
      old_hash = dummy.method :[]
      old_assign = dummy.method :[]=
      old_to_h = dummy.method :to_h
      dummy.start_smuggling(backend: nil)
      new_hash = dummy.method :[]
      new_assign = dummy.method :[]=
      new_to_h = dummy.method :to_h

      expect(old_hash).not_to eq(new_hash)
      expect(old_assign).not_to eq(new_assign)
      expect(old_to_h).not_to eq(new_to_h)
    end
  end

  context 'after loading' do
    let(:dummy_backend) {
      Class.new.tap { |c|
        c.instance_eval do
          def [](k)
            "hello :)"
          end

          def []=(k, v)
            {}
          end
        end
      }
    }

    let(:dummy) {
      Hash.new.tap { |c|
        c.extend(described_class); c.start_smuggling(backend: dummy_backend)
      }
    }

    it 'passes calls to the backend' do
      expect(dummy.trapdoor_set?).to eq(true)
      expect(dummy_backend).to receive(:[]).with("BOGUS").and_call_original
      expect(dummy["BOGUS"]).to eq("hello :)")

      expect(dummy_backend).to receive(:[]=).and_call_original
      dummy["BOGUS"] = "hi!"
    end
  end
end
