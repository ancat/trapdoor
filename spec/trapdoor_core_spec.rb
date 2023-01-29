require './lib/core'

RSpec.describe TrapdoorCore do
  context 'loading' do
    let(:dummy) { Hash.new.tap { |c| c.extend(described_class) } }

    it 'is not enabled until explicitly configured' do
      expect {
        dummy.start_smuggling(backend: nil)
      }.to change {
        dummy.trapdoor_set?
      }.from(false).to(true)
    end
  end
end
