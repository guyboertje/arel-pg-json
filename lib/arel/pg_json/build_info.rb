module Arel
  module PgJson
    class BuildInfo
      def initialize
        @files = `git ls-files -z`.split("\x0")
      end

      def add_to_gemspec(spec)
        spec.version       = version
        spec.authors       = authors
        spec.email         = emails
        spec.summary       = summary
        spec.description   = description

        spec.files         = files
        spec.executables   = executables
        spec.test_files    = test_files
        spec.license       = license

        self
      end

      private

      def version
        '0.0.2'
      end

      def authors
        ['Guy Boertje']
      end

      def emails
        ['guyboertje@gmail.com']
      end

      def summary
        %q{Arel nodes and vistor methods for Postgres Json datatype}
      end

      def description
        %q{Arel nodes and vistor methods for Postgres Json datatype}
      end

      def files
        @files
      end

      def executables
        @files.grep(%r{^bin/}) { |f| File.basename(f) }
      end

      def test_files
        @files.grep(%r{^(spec|features)/})
      end

      def license
        'MIT'
      end
    end
  end
end
