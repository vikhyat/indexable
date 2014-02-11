require 'indexable/phantomjs'

class PhantomjsTest < Test::Unit::TestCase
  def test_phantomjs_run
    file = Tempfile.new('phantomjstest')
    file.write("console.log('test');phantom.exit();")
    file.close
    assert_equal 'test', Phantomjs.new(file.path).run.strip
    file.unlink
  end

  def test_timeout
    file = Tempfile.new('phantomjstest')
    file.write("console.log('this will not exit');")
    file.close
    phantomjs = Phantomjs.new(file.path)
    phantomjs.timeout = 1
    assert_equal "Couldn't render page... orz.", phantomjs.run
    file.unlink
  end
end
