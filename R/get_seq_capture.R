#' 
#' 
#' 
get_seq_capture <- function(
    cod_source_info = NULL,
    cod_esp_gen = NULL,
    no_station = NULL,
    no_rel = NULL,
    pds_cpt = NULL,
    nb_capt = NULL
    # categ=NULL,
    # "pds_ech",
    # "nd_ech"
    ){

    query <- paste0("SELECT seq_capture, pds_capture_orig_mob, nb_ind_capture_mob FROM CAPTURE WHERE 1=1")
    paste0(query, " AND cod_source_info_mob=", cod_source_info)
    paste0(query, " AND cod_esp_gen=", cod_esp_gen)
    paste0(query, " AND no_station_trait_mob=", no_station)
    paste0(query, " AND no_releve_mob=", no_rel)
    # paste0(query, " AND pds_capture_orig_mob=", pds_cpt)
    # paste0(query, " AND nb_ind_capture_mob=", nb_capt)
    result <- DBI::dbGetQuery(oracle_conn, query)
    DBI::dbDisconnect(oracle_conn)

    if (nrow(result) != 1)
    {
        stop("get_seq_capture obtained more than one result")
    }
    if (result$pds_capture_orig_mob[1] != pds_capt){
        stop("get_seq_capture obtained a result that does not match given pds_capt")
    }
    if (result$nb_ind_capture_mob[1] != nb_capt){
        stop("get_seq_capture obtained a result that does not match given nb_capt")
    }
    seq_capture <- result$seq_capture[1]
    return(seq_capture)
}