<xsl:transform 
version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions"
><xsl:output
omit-xml-declaration="yes"
encoding="UTF-8"
indent="yes"
/><xsl:template match="base-object">return {
<xsl:for-each select="*"><xsl:choose>
<xsl:when test="name(.) = 'attributes'"><xsl:call-template name="flags"/></xsl:when>
<xsl:when test="name(.) = 'build-flags'"><xsl:call-template name="flags"/></xsl:when>
<xsl:when test="name(.) = 'order-flags'"><xsl:call-template name="flags"/></xsl:when>
<xsl:when test="name(.) = 'weapon'"><!--PASS--></xsl:when>
<xsl:when test="name(.) = 'action'"><!--PASS--></xsl:when>
<xsl:when test="name(.) = 'device'"><xsl:call-template name="basic-tree"/></xsl:when>
<xsl:when test="name(.) = 'rotation'"><xsl:call-template name="basic-tree"/></xsl:when>
<xsl:when test="name(.) = 'animation'"><xsl:call-template name="basic-tree"/></xsl:when>
<xsl:when test="name(.) = 'beam'"><xsl:call-template name="basic-tree"/></xsl:when>
<xsl:otherwise><xsl:call-template name="plain"/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
<xsl:if test="action">
["action"] = {
<xsl:for-each select="action">
[<xsl:number/>] = {
["id"] = <xsl:value-of select="@id"/>;
["count"] = <xsl:value-of select="@count"/>;
["trigger"] = <xsl:value-of select="@trigger"/>;
};
</xsl:for-each>
};
</xsl:if>

<xsl:if test="weapon">
["weapon"] = {
<xsl:for-each select="weapon">
[<xsl:number/>] = {
["id"] = <xsl:value-of select="@id"/>;
["type"] = <xsl:value-of select="@type"/>;
["position"] = {
<xsl:for-each select="position">[<xsl:number/>] = {
["x"] = <xsl:value-of select="@x"/>;
["y"] = <xsl:value-of select="@y"/>;
};
</xsl:for-each>
};
};
</xsl:for-each>
};
</xsl:if>
};
</xsl:template>

<xsl:template name="flags">["<xsl:value-of select="name(.)"/>"] = {
<xsl:for-each select="*">	["<xsl:value-of select="name(.)"/>"] = true;
</xsl:for-each>
};
</xsl:template>

<xsl:template name="basic-tree">["<xsl:value-of select="name(.)"/>"] = {
<xsl:for-each select="*">	<xsl:call-template name="plain"/></xsl:for-each>};
</xsl:template>

<xsl:template name="plain">["<xsl:value-of select="name(.)"/>"] = <xsl:choose>
<xsl:when test="@real"><xsl:value-of select="@real"/></xsl:when>
<xsl:when test="@integer"><xsl:value-of select="@integer"/></xsl:when>
<xsl:when test="@string">"<xsl:value-of select="@string"/>"</xsl:when>
<xsl:when test="@bool">"<xsl:value-of select="@bool"/>"</xsl:when>
</xsl:choose>;
</xsl:template>

<xsl:template name="action">return {
["type"] = "<xsl:value-of select="name(.)"/>";
<xsl:for-each select="*"><xsl:call-template name="plain"/></xsl:for-each>
};
</xsl:template>

<xsl:template match="initial-object">return {
<xsl:for-each select="*">
<xsl:choose>
<xsl:when test="name(.) = 'location'">["location"] = {
["x"]=<xsl:value-of select="@x"/>;
["y"]=<xsl:value-of select="@y"/>;
};</xsl:when>
<xsl:otherwise><xsl:call-template name="plain"/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
};
</xsl:template>

<xsl:template match="race">
return {
<xsl:for-each select="*"><xsl:call-template name="plain"/></xsl:for-each>
};
</xsl:template>

<xsl:template match="scenario">
return {
<xsl:for-each select="*">
<xsl:choose>
<xsl:when test="player"><!--PASS--></xsl:when>
<xsl:when test="score-string">
["score-string"] = {
<xsl:for-each select="line">
["<xsl:number/>"] = "<xsl:value-of select="@string"/>";
</xsl:for-each>
};
</xsl:when>
<xsl:when test="star-map-location">
["star-map-location"] = {
["x"] = <xsl:value-of select="@x"/>;
["y"] = <xsl:value-of select="@y"/>;
};
</xsl:when>
<xsl:when test="initial"><xsl:call-template name="id-count"/></xsl:when>
<xsl:when test="condition"><xsl:call-template name="id-count"/></xsl:when>
<xsl:when test="brief-point"><xsl:call-template name="id-count"/></xsl:when>
<xsl:otherwise><xsl:call-template name="plain"/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
["player"] = {
<xsl:for-each select="player">
["<xsl:number/>"] = {
<xsl:for-each select="*">
<xsl:choose>
<xsl:when test="net-races">
<xsl:for-each select="*">
["<xsl:number/>"] = <xsl:value-of select="@integer"/>;
</xsl:for-each>
</xsl:when>
<xsl:otherwise><xsl:call-template name="plain"/></xsl:otherwise>
</xsl:choose>
</xsl:for-each>
};
</xsl:for-each>
};
};
</xsl:template>


<xsl:template name="id-count">
["<xsl:value-of select="name(.)"/>"] = {
["id"] = <xsl:value-of select="@id"/>;
["count"] = <xsl:value-of select="@count"/>;
};
</xsl:template>
<!--
I wish chris had exported the actions as something like:
<action>
	<type type="some-type-action"/>
	...
</action>
OR
<action>
	<type>some-type-action</type>
	...
</action>
OR
<action type="some-type-action">
	...
</action>

If he had this part would be MUCH saner.
27 templates each calling the same template.
-->
<xsl:template match="activate-special-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-absolute-cash-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-absolute-location-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-age-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-base-type-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-cloak-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-condition-true-yet-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-damage-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-energy-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-hidden-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-location-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-max-velocity-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-occupation-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-offline-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-owner-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-special-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-spin-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-thrust-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="alter-velocity-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="assume-initial-object-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="change-score-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="color-flash-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="computer-select-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="create-object-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="create-object-set-dest-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="declare-winner-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="die-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="disable-keys-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="display-message-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="enable-keys-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="land-at-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="make-sparks-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="nil-target-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="no-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="play-sound-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="set-destination-action"><xsl:call-template name="action"/></xsl:template>
<xsl:template match="set-zoom-action"><xsl:call-template name="action"/></xsl:template>


</xsl:transform>

