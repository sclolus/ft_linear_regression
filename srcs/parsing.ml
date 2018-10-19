(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   parsing.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 06:03:59 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/19 01:39:54 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let parse_dataset in_channel: Dataset.dataset  =
  let rec aux in_channel acc =
    let line = try Some (input_line in_channel) with
               | End_of_file -> None
               | Sys_error err_string ->
                  begin
                    prerr_endline err_string ;
                    None
                  end
               | _ ->
                  begin
                    prerr_endline "Unexpected error" ;
                    None
                  end
    in
    match line with
    | Some line -> let field_strings = String.split_on_char ',' line in
                   let fields = List.map (fun str -> int_of_string_opt str) field_strings in
                   let check_integrity_closure = (fun field -> match field with
                                                 | Some _ -> true
                                                 | _ -> false)  in
                   if List.for_all check_integrity_closure fields && List.length fields = 2
                   then
                     begin
                       let extract_closure = (fun field -> match field with
                                                           | Some field -> field
                                                           | None -> failwith "get_closure called on None value") in
                       let fields = List.map extract_closure fields in
                       aux in_channel ((float_of_int (List.hd fields), float_of_int (List.nth fields 1)) :: acc)
                     end
                   else
                     aux in_channel acc
                              
    | None -> acc
  in
  List.rev (aux in_channel [])
  
