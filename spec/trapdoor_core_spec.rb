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
end
