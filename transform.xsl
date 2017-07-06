<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" />
  <xsl:strip-space elements="*"/>

  <!-- main template -->
  <xsl:template match="/fxf/report">
  {
    "metadata": {
      "reportName": "<xsl:value-of select="created/@focexec"/>",
      "headings": {<xsl:apply-templates select="column_desc/col[@class = 'heading']"/>
      },
      "columns": {<xsl:apply-templates select="column_desc/col[@class = 'title']"/>
      }
    },
    "rows": [<xsl:apply-templates select="table/tbody/tr"/>
    ]
  }
  </xsl:template>

      <!-- heading template -->
      <xsl:template match="column_desc/col[@class = 'heading']">
        <xsl:variable name="columnNumber" select="@colnum" />
        <xsl:variable name="columnPosition" select="@fieldnum"/>
        "<xsl:value-of select="$columnNumber"/>": {<xsl:for-each select="//table/thead/tr/td[@colnum=$columnNumber]">
          "<xsl:value-of select="@id"/>": "<xsl:value-of select="."/>"<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
        </xsl:for-each>
        }<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
      </xsl:template>

      <!-- column title template -->
      <xsl:template match="column_desc/col[@class = 'title']">
        <xsl:variable name="columnNumber" select="@colnum" />
        <xsl:variable name="columnPosition" select="@fieldnum"/>
        <xsl:variable name="fieldNumber" select="/fxf/report/column_desc/col[@colnum=$columnNumber]/@fieldnum" />
        <xsl:variable name="fieldName" select="/fxf/report/field_desc/field[@fieldnum=$fieldNumber]/@fieldname" />
        <xsl:variable name="alias" select="/fxf/report/field_desc/field[@fieldnum=$fieldNumber]/@alias" />
        <xsl:variable name="focusFormat" select="/fxf/report/field_desc/field[@fieldnum=$fieldNumber]/@focus_format" />
        <xsl:variable name="description" select="/fxf/report/field_desc/field[@fieldnum=$fieldNumber]/@description" />
        "<xsl:value-of select="$fieldName"/>": {
          "title": "<xsl:for-each select="//table/thead/tr/td[@colnum=$columnNumber]">
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
          </xsl:for-each>",
          "columnNumber": "<xsl:value-of select="$columnNumber"/>",
          "columnPosition": <xsl:value-of select="$columnPosition"/>,
          "fieldNumber": <xsl:value-of select="$fieldNumber"/>,
          "alias": <xsl:choose><xsl:when test="$alias">"<xsl:value-of select="$alias"/>"</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose>,
          "focusFormat": <xsl:choose><xsl:when test="$focusFormat">"<xsl:value-of select="$focusFormat"/>"</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose>,
          "description": <xsl:choose><xsl:when test="$description">"<xsl:value-of select="$description"/>"</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose>
        }<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
      </xsl:template>

  <!-- table rows (tr) template  -->
  <xsl:template match="tbody/tr">
      {
        "lineType": "<xsl:value-of select="@linetype"/>",
        "lineNumber": <xsl:value-of select="@linenum"/>,
        "data": {<xsl:for-each select="td">
          <xsl:variable name="columnNumber" select="@colnum" />
          <xsl:variable name="fieldNumber" select="/fxf/report/column_desc/col[@colnum=$columnNumber]/@fieldnum" />
          <xsl:variable name="fieldName" select="/fxf/report/field_desc/field[@fieldnum=$fieldNumber]/@fieldname" />
          "<xsl:choose>
            <xsl:when test="$fieldName"><xsl:value-of select="$fieldName"/></xsl:when>
            <xsl:otherwise>CST<xsl:value-of select="position()"/></xsl:otherwise>
          </xsl:choose>": <xsl:choose>
            <xsl:when test="@rawvalue and number(@rawvalue)"><xsl:value-of select="@rawvalue"/></xsl:when>
            <xsl:otherwise>"<xsl:value-of select="normalize-space(text())"/>"</xsl:otherwise>
          </xsl:choose><xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
        </xsl:for-each>
        }
      }<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
  </xsl:template>

</xsl:stylesheet>