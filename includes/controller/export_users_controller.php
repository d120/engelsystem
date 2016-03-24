<?php
/**
 * Created by PhpStorm.
 * User: matedealer
 * Date: 3/23/16
 * Time: 7:29 PM
 */

function users_export_controller($type)
{
	if (isset($_REQUEST['key']) && preg_match("/^[0-9a-f]{32}$/", $_REQUEST['key']))
		$key = $_REQUEST['key'];
	else
		die("Missing key.");

	$user = User_by_api_key($key);
	if ($user === false)
		die("Unable to find user.");
	if ($user == null)
		die("Key invalid.");
	if (!in_array('admin_user', privileges_for_user($user['UID'])))
		die("No privilege for export users.");
	
	if ($type == 'csv')
		export_csv();
	elseif ($type == 'mail')
		export_mail();

}


function export_csv(){
	/**** Felder von der Kiffel-Verwaltung
	nickname = models.CharField(max_length=100, verbose_name='Nickname (Namensschild)')
    vorname = models.CharField(max_length=100)
    nachname = models.CharField(max_length=100)
    email = models.EmailField(verbose_name='E-Mail')
    student = models.BooleanField()
    hochschule = models.CharField(max_length=100, verbose_name='Hochschule/Ort/Verein')
    kommentar_public = models.TextField(null=True, blank=True, verbose_name='Kommentar öffentlich')
    kommentar_orga = models.TextField(null=True, blank=True, verbose_name='Kommentar Orga')
    anreise_geplant = models.DateTimeField()
    abreise_geplant = models.DateTimeField()
    ernaehrungsgewohnheit = models.CharField(max_length=100, null=True, blank=True,
		    verbose_name='Ernährungsgewohnheit')
    lebensmittelunvertraeglichkeiten = models.CharField(max_length=400, null=True, blank=True,
		    verbose_name='Lebensmittelunverträglichkeiten')
    volljaehrig = models.BooleanField(verbose_name='Volljährig (über 18)')
    eigener_schlafplatz = models.BooleanField(verbose_name='Hat eigenen Schlafplatz')
    tshirt_groesse = models.CharField(max_length=10, verbose_name='T-Shirt-Größe')
    nickname_auf_tshirt = models.BooleanField(verbose_name='Nickname auf T-Shirt drucken')
    kapuzenjacke_groesse = models.CharField(max_length=10, null=True, blank=True,
		    verbose_name='Kapuzenjacke (evtl. Größe)')
    nickname_auf_kapuzenjacke = models.BooleanField(verbose_name='Nickname auf Kapuzenjacke drucken')
    weitere_tshirts = models.CharField(max_length=100, null=True, blank=True, verbose_name='Weitere T-Shirts')
    interesse_theater = models.BooleanField(verbose_name='Interesse an Theaterbesuch')
    interesse_esoc = models.BooleanField(verbose_name='Interesse an ESOC-Führung')
    anmeldung_angelegt = models.DateTimeField()
    anmeldung_aktualisiert = models.DateTimeField()
	datum_bezahlt = models.DateTimeField(null=True, blank=True, verbose_name='Teilnahmebeitrag bezahlt')
    datum_tshirt_erhalten = models.DateTimeField(null=True, blank=True, verbose_name='T-Shirt erhalten')
    datum_teilnahmebestaetigung_erhalten = models.DateTimeField(null=True, blank=True,
		    verbose_name='Teilnahmebestätigung erhalten')
    status = models.CharField(max_length=100, null=True, blank=True)
    kommentar = models.TextField(null=True, blank=True)
    engel_handle = models.CharField(max_length=100, null=True, blank=True, verbose_name='Name im Engelsystem')
    twitter_handle = models.CharField(max_length=100, null=True, blank=True, verbose_name='Twitter-Handle')
    kdv_id = models.CharField(max_length=32, null=True, blank=True, verbose_name='KDV-ID')
    ist_orga = models.BooleanField(default=False, verbose_name='Kiffel ist Orga')
***/
	$user_list = sql_select("SELECT UID, Nick, Vorname, Name, email, size, kommentar FROM  User ");
	header('Content-Type: text/csv; charset=utf-8');
	header('Content-Disposition: attachment; filename=data.csv');

// create a file pointer connected to the output stream
	$output = fopen('php://output', 'w');

// output the column headings
	fputcsv($output, array('ID', "nickname", "vorname", "nachname", "email", "tshirt_groesse", "kommentar_orga"));
	foreach($user_list as &$user){
		fputcsv($output, $user);
	}
	//echo('foooo');
	die();
}

function export_mail(){
	$mail_list = sql_select('SELECT email FROM User');
	header("Content_Type: text/plain; charset=utf-8");
	header('Content-Disposition: attachment; filename=mails.dat');
	foreach ($mail_list as &$mail)
		print($mail['email']."\n");
	die();
}


