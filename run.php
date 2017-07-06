<?php

// Load the XML source
$xml = new DOMDocument;
$xml->load('./examples/car/sample_xmlr.xml');

$xsl = new DOMDocument;
$xsl->load('transform.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules

echo $proc->transformToXML($xml);