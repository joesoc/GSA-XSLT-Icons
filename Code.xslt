  <table><tr><td id="fileicons" style="padding-right:10px"><xsl:choose>
      <xsl:when test="@MIME='application/octet-stream'"><img src="/Global/Images/Icons/zip.png"></img></xsl:when>
      <xsl:when test="@MIME='text/html' or @MIME='' or not(@MIME)"></xsl:when>
      <xsl:when test="@MIME='text/plain'">[TEXT]</xsl:when>
      <xsl:when test="@MIME='application/rtf'">[RTF]</xsl:when>
      <xsl:when test="@MIME='application/pdf'"><img src="_/Global/Images/Icons/pdf.png"></img></xsl:when>
      <xsl:when test="@MIME='application/postscript'">[PS]</xsl:when>
      <xsl:when test="@MIME='application/vnd.ms-powerpoint'"><img src="_/Global/Images/Icons/pptx.png"></img></xsl:when>
      <xsl:when test="@MIME='application/vnd.openxmlformats-officedocument.presentationml.presentation'"><img src="_/Global/Images/Icons/pptx.png"></img></xsl:when>
      <xsl:when test="@MIME='application/vnd.ms-excel'"><img src="_/Global/Images/Icons/xls.png"></img></xsl:when>
      <xsl:when test="@MIME='application/msword'"><img src="_/Global/Images/Icons/doc.png"></img></xsl:when>
      <xsl:when test="@MIME='application/vnd.openxmlformats-officedocument.wordprocessingml.document'"><img src="_/Global/Images/Icons/doc.png"></img></xsl:when>
      <xsl:otherwise>
        <xsl:variable name="extension">
          <xsl:call-template name="last_substring_after">
            <xsl:with-param name="string" select="substring-after(
                                                  $temp_url,
                                                  '/')"/>
            <xsl:with-param name="separator" select="'.'"/>
            <xsl:with-param name="fallback" select="'UNKNOWN'"/>
          </xsl:call-template>
        </xsl:variable>
        [<xsl:value-of select="translate($extension,$lower,$upper)"/>]
      </xsl:otherwise>
    </xsl:choose></td><td>  <xsl:if test="$show_res_title != '0'">
    <font size="-2"><b>
    
    </b></font>
    <xsl:text> </xsl:text>
    <xsl:variable name="link"
     select="$url_indexed and not(starts-with(U, $googleconnector_protocol))"/>

    <xsl:if test="$link">

      <xsl:text disable-output-escaping='yes'>&lt;a 
            ctype="c" target="_parent"
      </xsl:text>
            rank=&quot;<xsl:value-of select="position()"/>&quot;
      <xsl:text disable-output-escaping='yes'>
            href="</xsl:text>

      <xsl:choose>
        <xsl:when test="starts-with(U, $dbconnector_protocol)">
          <xsl:variable name="cache_encoding">
            <xsl:choose>
              <xsl:when test="'' != HAS/C/@ENC"><xsl:value-of select="HAS/C/@ENC"/></xsl:when>
              <xsl:otherwise>UTF-8</xsl:otherwise>
            </xsl:choose>
            </xsl:variable><xsl:value-of select="$gsa_search_root_path_prefix"/>?q=cache:<xsl:value-of select="HAS/C/@CID"/>:<xsl:value-of select="$stripped_url"/>+<xsl:value-of select="$stripped_search_query"/>&amp;<xsl:value-of select="$base_url"/>&amp;oe=<xsl:value-of select="$cache_encoding"/>
        </xsl:when>

        <xsl:when test="starts-with(U, $db_url_protocol)">
          <xsl:value-of disable-output-escaping='yes'
                        select="concat('db/', $temp_url)"/>
        </xsl:when>
        <!-- *** URI for smb or NFS must be escaped because it appears in the URI query *** -->
        <xsl:when test="$protocol='nfs' or $protocol='smb'">
          <xsl:value-of disable-output-escaping='yes'
                        select="concat($protocol,'/',$temp_url)"/>
        </xsl:when>
        <xsl:when test="$protocol='unc'">
          <xsl:value-of disable-output-escaping='yes' select="concat('file://', $display_url2)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of disable-output-escaping='yes' select="U"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text disable-output-escaping='yes'>"&gt;</xsl:text>
    </xsl:if>
    <span id="title_{$res_num}" class="l">
    <xsl:choose>
      <xsl:when test="T">
        <span class= "goog-trans-section l" transId="gadget_{$res_num}">
          <xsl:call-template name="reformat_keyword">
            <xsl:with-param name="orig_string" select="T"/>
          </xsl:call-template>
        </span>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$stripped_url"/></xsl:otherwise>
    </xsl:choose>
    </span>
    <xsl:if test="$link">
        <xsl:text disable-output-escaping='yes'>&lt;/a&gt;</xsl:text>
    </xsl:if>
  </xsl:if>


  <!-- *** Snippet Box *** -->
  <table cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="s">
        <xsl:if test="$show_res_snippet != '0' and string-length(S) and
                      $only_apps != '1'">
          <span id="snippet_{$res_num}" class= "goog-trans-section" transId="gadget_{$res_num}">
            <xsl:call-template name="reformat_keyword">
              <xsl:with-param name="orig_string" select="S"/>
            </xsl:call-template>
          </span>
        </xsl:if>

        <!-- *** Meta tags *** -->
        <xsl:if test="$show_meta_tags != '0' and $only_apps != '1'">
          <xsl:apply-templates select="MT"/>
        </xsl:if>

        <xsl:if test="$only_apps != '1' and
                      ($show_res_snippet != '0' and string-length(S)) or
                      ($show_meta_tags != '0' and MT[(@N != '') or (@V != '')])">
        <br/>
        </xsl:if>

        <!-- *** URL *** -->
        <xsl:if test="$only_apps != '1' or
                      ($only_apps = '1' and $show_apps_segmented_ui != '1')">
        <font color="{$res_url_color}" size="{$res_url_size}">
          <xsl:choose>
            <xsl:when test="not($url_indexed)">
              <xsl:if test="($show_res_size!='0') or
                            ($show_res_date!='0') or
                            ($show_res_cache!='0')">
                <xsl:text>Not Indexed:</xsl:text>
                <xsl:value-of select="$stripped_url"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$show_res_url != '0'">
                <xsl:value-of select="$stripped_url"/>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </font>
        </xsl:if>

        <!-- *** Miscellaneous (- size - date - cache) *** -->
        <xsl:if test="$url_indexed">
        <xsl:choose>
          <xsl:when test="'' != HAS/C/@ENC">
           <xsl:apply-templates select="HAS/C">
                         <xsl:with-param name="stripped_url" select="$stripped_url"/>
                         <xsl:with-param name="escaped_url" select="$escaped_url"/>
                         <xsl:with-param name="query" select="$query"/>
                         <xsl:with-param name="mime" select="@MIME"/>
                         <xsl:with-param name="date" select="FS[@NAME='date']/@VALUE"/>
                         <xsl:with-param name="result_num" select="$res_num"/>
           </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
          <xsl:call-template name="showdate">
              <xsl:with-param name="date" select="FS[@NAME='date']/@VALUE"/>
          </xsl:call-template>
          </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- *** Link to more links from this site *** -->
        <xsl:if test="HN">
          <br/>
          [
          <a ctype="sitesearch" class="f" href="{$gsa_search_root_path_prefix}?as_sitesearch={$crowded_url}&amp;{
            $search_url}">More results from <xsl:value-of select="$crowded_display_url"/></a>
          ]

        <!-- *** Link to aggregated results from database source *** -->
        <xsl:if test="starts-with($crowded_url, $db_url_protocol)">
        [
        <a ctype="db" class="f" href="dbaggr?sitesearch={$crowded_url}&amp;{
          $search_url}&amp;filter=0">View all data</a>
            ]
          </xsl:if>
        </xsl:if>


        <!-- *** Result Footer *** -->
      </td>
    </tr>
  </table></td></tr></table>