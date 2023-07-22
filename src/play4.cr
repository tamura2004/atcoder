require "xml"
require "compress/zip"

private def doc
  XML.parse(%(\
  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="16" uniqueCount="8">
    <si>
      <t>動物</t>
      <rPh sb="0" eb="2">
        <t>ドウブツ</t>
      </rPh>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>日付</t>
      <rPh sb="0" eb="2">
        <t>ヒヅケ</t>
      </rPh>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>匹</t>
      <rPh sb="0" eb="1">
        <t>ヒキ</t>
      </rPh>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>犬</t>
      <rPh sb="0" eb="1">
        <t>イヌ</t>
      </rPh>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>猫</t>
      <rPh sb="0" eb="1">
        <t>ネコ</t>
      </rPh>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>ネズミ</t>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>カラス</t>
      <phoneticPr fontId="1"/>
    </si>
    <si>
      <t>大熊猫</t>
      <rPh sb="0" eb="3">
        <t>オオクマネコ</t>
      </rPh>
      <phoneticPr fontId="1"/>
    </si>
  </sst>
    ))
end

Dir.glob("/mnt/g/a.xlsx") do |filename|
  Compress::Zip::File.open(filename) do |zip|
    zip["xl/_rels/workbook.xml.rels"].open do |io|
      XML.parse(io).tap do |node|
        pp "xl/_rels/workbook.xml.rels"
        puts node.to_xml
      end
    end

    zip["xl/workbook.xml"].open do |io|
      XML.parse(io).tap do |node|
        pp "xl/workbook.xml"
        puts node.to_xml
      end
    end
    
    zip["xl/styles.xml"].open do |io|
      XML.parse(io).tap do |node|
        pp "xl/styles.xml"
        puts node.to_xml
      end
    end
    # exit
    strings = [] of String
    zip["xl/sharedStrings.xml"].open do |io|
      XML.parse(io).tap do |node|
        strings = node.xpath_nodes("*[name()='sst']/*[name()='si']/*[name()='t']").map(&.content)
      end
    end

    zip["xl/worksheets/sheet1.xml"].open do |io|
      XML.parse(io).tap do |node|
        node.xpath_nodes("//*[name()='row']").each do |row|
          puts "=" * 30
          puts row.to_xml
          row.xpath_nodes("*[name()='c']").each do |cell|
            cell.xpath_node("*[name()='v']").try do |v|
              puts  "-" * 20
              if cell["t"]? == "s"
                puts strings[v.content.to_i]
              else
                puts v.content
              end

              puts cell.to_xml
              puts cell.content
              pp! cell["t"]?
              pp! cell["s"]?
            end
          end
        end
      end
    end
  end
  exit
end


# xml = <<-XML
# <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
# <worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac xr xr2 xr3" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac" xmlns:xr="http://schemas.microsoft.com/office/spreadsheetml/2014/revision" xmlns:xr2="http://schemas.microsoft.com/office/spreadsheetml/2015/revision2" xmlns:xr3="http://schemas.microsoft.com/office/spreadsheetml/2016/revision3" xr:uid="{EEB68E17-948E-4164-98E0-F8FD69F63781}"><dimension ref="A1:C4"/><sheetViews><sheetView tabSelected="1" workbookViewId="0"><selection activeCell="E6" sqref="E6"/></sheetView></sheetViews><sheetFormatPr defaultRowHeight="18.75" x14ac:dyDescent="0.4"/><cols><col min="2" max="2" width="10.25" bestFit="1" customWidth="1"/></cols><sheetData><row r="1" spans="1:3" x14ac:dyDescent="0.4"><c r="A1" t="s"><v>0</v></c><c r="B1" t="s"><v>1</v></c><c r="C1" t="s"><v>2</v></c></row><row r="2" spans="1:3" x14ac:dyDescent="0.4"><c r="A2"><v>1</v></c><c r="B2" s="1"><v>45056</v></c><c r="C2" t="s"><v>3</v></c></row><row r="3" spans="1:3" x14ac:dyDescent="0.4"><c r="A3"><v>2</v></c><c r="B3" s="1"><v>45056</v></c><c r="C3" t="s"><v>4</v></c></row><row r="4" spans="1:3" x14ac:dyDescent="0.4"><c r="A4"><v>3</v></c><c r="B4" s="1"><v>45056</v></c><c r="C4" t="s"><v>5</v></c></row></sheetData><phoneticPr fontId="1"/><pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/></worksheet>
# XML

# ans = [] of Array(String)
# reader = XML::Reader.new(xml)
# while reader.read
#   if reader.node_type.element? && reader.name == "row"
#     ans << [] of String
#     pp! reader["r"]
#   elsif reader.name == "#text"
#     ans[-1] << reader.value
#   end
# end
# pp ans

# pp Time.utc(1899,12,31) + 45056.days

# # doc = XML.parse(xml)
# # doc.xpath_nodes("//*[name()='row']").each do |row|
# #   row.xpath_nodes("//*[name()='c']").each do |cell|
# #     pp! cell["r"]?
# #     pp! cell["t"]?
# #     pp! cell["s"]?
# #   end
# # end
