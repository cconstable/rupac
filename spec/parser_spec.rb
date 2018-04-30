require 'rupac'
require 'exceptions/invalid_parser_input'

RSpec.describe Rupac::Parser do
  it "has a parse function" do
    expect(Rupac::Parser.instance_methods.include? :parse).to be true
  end

  it "accepts strings as input" do
    parser = Rupac::Parser.new { |i| Rupac::ParserResult.pass(result: 1, residual: nil) }
    expect { parser.parse('a') }.not_to raise_error
    expect { parser.parse('abc') }.not_to raise_error
  end

  context "is a functor" do
    it "can be mapped" do
      parser = Rupac::Parser.new { |i| Rupac::ParserResult.pass(result: 1, residual: nil) }
      mapped_parser = parser.map { |v| v + 9 }
      expect(mapped_parser).to be_a Rupac::Parser
      expect(mapped_parser.parse("").result).to eq 10
    end

    context "is an applicative functor" do
      it "can wrap values with pure" do
        parser = Rupac::Parser.pure(1)
        expect(parser.parse('abc').result).to eq 1

        parser = Rupac::Parser.pure('hello')
        expect(parser.parse('1234').result).to eq 'hello'
      end

      it "can wrap functions with pure" do
        parser = Rupac::Parser.pure(-> x { x + 1 })
        expect(parser.parse('abc').result.(2)).to eq 3

        block = -> x { x + 1 }
        parser = Rupac::Parser.pure(&block)
        expect(parser.parse('abc').result.(10)).to eq 11
      end

      it "can have n-ary functions applied" do
        parser = Rupac::Parser.pure(-> x, y { x + y })
          .apply(Rupac::Parser.pure(10))
          .apply(Rupac::Parsers.number)

        expect(parser.parse('1').result).to eq 11
        expect(parser.parse('3').result).to eq 13
        expect(parser.parse('10').result).to eq 20
      end

      context "is a monad" do
        it "obeys left identity" do
          f = -> i { P.match(i) }
          flatmapped_parser = Rupac::Parser.pure('abc') >= f
          direct_invocation_parser = f.('abc')

          expect(flatmapped_parser.parse('abc')).to eq direct_invocation_parser.parse('abc')
        end

        it "obeys right identity" do
          parser = Rupac::Parser.pure('abc')
          f = -> i { Rupac::Parser.pure(i) }
          flatmapped_parser = parser >= f

          expect(flatmapped_parser.parse('abc')).to eq parser.parse('abc')
        end

        it "obeys associativity" do
          parser = P.match('a')
          f1 = -> i { P.match('b') }
          f2 = -> i { P.match('c') }
          output1 = parser
            .flat_map { |i| f1.(i) }
            .flat_map { |i| f2.(i) }
          output2 = parser
            .flat_map { |i| f1.(i).flat_map { |ii| f2.(ii) }}

          expect(output1.parse('abc')).to eq output2.parse('abc')
        end

        it "can be flat_mapped" do
          init = -> r { (r % 2 == 1) ? P.match('a') : P.match('b') }
          parser = P.number.flat_map(&init) >> P.eof

          expect(parser.parse(%Q(1a)).passed?).to be_truthy
          expect(parser.parse(%Q(1b)).passed?).to be_falsey
          expect(parser.parse(%Q(2a)).passed?).to be_falsey
          expect(parser.parse(%Q(2b)).passed?).to be_truthy
        end
      end
    end
  end
end
