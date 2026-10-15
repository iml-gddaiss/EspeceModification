
#' Modification taxonomique
#' 
#' L'identification originale était incorrecte et doit être remplacée par une autre espèce ou un autre taxon. Cette manœuvre a comme but de modifier une entrée dans la table CAPTURE. 
#'
#' @param cod_source_info Numeric, part of the composed key to the unique CAPTURE entry
#' @param cod_esp_gen Numeric, part of the composed key to the unique CAPTURE entry
#' @param no_station Numeric, part of the composed key to the unique CAPTURE entry
#' @param no_rel Numeric, part of the composed key to the unique CAPTURE entry
#' @param pds_cpt Numeric, used to validate the CAPTURE item
#' @param nb_capt Numeric, used to validate the CAPTURE item
#' @param categ Numeric, unused for modifying CAPTURE entry
#' @param pds_ech Numeric, unused for modifying CAPTURE entry
#' @param nd_ech Numeric, unused for modifying CAPTURE entry
#' @param aphia_id, Numeric, the new aphia_id for the CAPTURE item. The aphia_id has to exist in ESPECE_GENERAL 
#' @export
modif_taxo <- function(
    cod_source_info = NULL,
    cod_esp_gen = NULL,
    no_station = NULL,
    no_rel = NULL,
    pds_cpt = NULL,
    nb_capt = NULL,
    categ = NULL,
    pds_ech = NULL,
    nd_ech = NULL,
    aphia_id = NULL
    ) {

    # the filter on CAPTURE that should yeild the unique target entry
    filter <- "WHERE 1=1"
    paste0(filter, " AND cod_source_info_mob=", cod_source_info)
    paste0(filter, " AND cod_esp_gen=", cod_esp_gen)
    paste0(filter, " AND no_station_trait_mob=", no_station)
    paste0(filter, " AND no_releve_mob=", no_rel)

    # first, validate original entry
    query <- paste0("SELECT * FROM CAPTURE")
    query <- paste0(query, filter)
    entry <- DBI::dbGetQuery(oracle_conn, query)

    if (nrow(entry) != 1)
    {
        stop("filter failed to obtain a unique entry from CAPTURE")
    }
    if (entry$pds_capture_orig_mob[1] != pds_capt){
        stop("entry to modify contains an unexpected pds_capt")
    }
    if (entry$nb_ind_capture_mob[1] != nb_capt){
        stop("entry to modify contains an unexpected nb_capt")
    }

    # get the new cod_esp_gen
    cod_esp_gen_new <- get_cod_esp_gen(aphia_id = aphia_id)

    if (is.na(cod_esp_gen_new)) {
        stop("cette modification taxonomique nécessite l'ajoute de d'une nouvelle espece en premier.")
    }

    # all sanity checks have passed, build the transaction statement

    # build the new rem_capture
    rem_capture_new <- paste0(entry$rem_capture[1], " modification de cod_esp_gen, ", cod_esp_gen, "->", cod_esp_gen_new, ";")

    # TODO: prevent SQL injection
    statement <- "UPDATE CAPTURE SET"
    statement <- paste0(statement, " SET cod_esp_gen=cod_esp_gen_new")
    statement <- paste0(statement, ", SET rem_capture=rem_capture_new")
    statement <- paste0(statement, filter, ";")
    return(statement)

}
