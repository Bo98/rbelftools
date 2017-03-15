# Require this file to load all sections classes.

require 'elftools/sections/section'

require 'elftools/sections/note_section'
require 'elftools/sections/null_section'
require 'elftools/sections/str_tab_section'
require 'elftools/sections/sym_tab_section'

module ELFTools
  # Defines different types of sections in this module.
  module Sections
    # Class methods of {Sections::Section}.
    class << Section
      # Use different class according to +header.sh_type+.
      # @param [ELFTools::ELF_Shdr] header Section header.
      # @param [File] stream Streaming object.
      # @return [ELFTools::Sections::Section]
      #   Return object dependes on +header.sh_type+.
      def create(header, stream, *args)
        klass = case header.sh_type
                when Constants::SHT_NULL then NullSection
                when Constants::SHT_STRTAB then StrTabSection
                when Constants::SHT_NOTE then NoteSection
                when Constants::SHT_SYMTAB, Constants::SHT_DYNSYM then SymTabSection
                else Section
                end
        klass.new(header, stream, *args)
      end
    end
  end
end
