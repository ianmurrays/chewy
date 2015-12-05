module ClassHelpers
  extend ActiveSupport::Concern

  def stub_index name, superclass = nil, &block
    stub_class("#{name.to_s.camelize}Index", superclass || Chewy::Index) { index_name = name }
      .tap { |i| i.class_eval(&block) if block }
  end

  def stub_class name, superclass = nil, &block
    stub_const(name.to_s.camelize, Class.new(superclass || Object, &block))
  end

  def stub_model name, superclass = nil, &block
    raise NotImplementedError, 'Seems like no ORM/ODM are loaded, please check your Gemfile'
  end

  def skip_on_version_gte version
    skip "Removed from elasticsearch #{version}" if Chewy::Runtime.version >= version
  end

  def skip_on_version_lt version
    skip "Only for elasticsearch #{version} and greater" if Chewy::Runtime.version < version
  end
end
