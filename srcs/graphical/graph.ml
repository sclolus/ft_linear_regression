(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   graph.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/25 00:18:12 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/25 03:18:24 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let point_size = 4
let border_padding = 100
let fborder_padding = float_of_int border_padding
                    
let draw_dataset dataset =
  let features = List.sort (fun a b -> compare a b) (List.map (fun (feature, _) -> feature) dataset) in
  let results = List.sort (fun a b -> compare a b) (List.map (fun (_, result) -> result) dataset) in
  if List.length dataset <> 0
  then let min_x = List.hd results in
       let min_y = List.hd features in
       let max_x = List.nth results (List.length results - 1) in
       let max_y = List.nth features (List.length features - 1) in
       let win_width = Graphics.size_x () in
       let win_height = Graphics.size_y () in
       let x_per_pixel =  (max_x -. min_x +. fborder_padding) /. (float_of_int win_width) in
       let y_per_pixel =  (max_y -. min_y +. fborder_padding) /. (float_of_int win_height) in
       let draw_point x y =
         Graphics.draw_circle (int_of_float x) (int_of_float y) (point_size)
       in
       let rec draw_point_list point_list =
         match point_list with
         | (y, x) :: tl -> let x = ((x -. min_x) /. x_per_pixel) in
                           let y = ((y -. min_y) /. y_per_pixel) in
                           (* Printf.printf "x = %f, y = %f x_per_pixel: %f y_per_pixel: %f\n" x y x_per_pixel y_per_pixel;
                            * Printf.printf "win_widht : %f win_height : %f\n" (float_of_int win_width) (float_of_int win_height) ; *)
                           assert (x >= 0.0 && x <= (float_of_int win_width));
                           assert (y >= 0.0 && y <= (float_of_int win_height));
            draw_point x y ;
                           draw_point_list tl
         | [] -> ()
       in
       draw_point_list dataset
       
       
       
                             
let draw_linear_function intercept slope start_x end_x start_y end_y =
  let win_width = Graphics.size_x () - border_padding in
  let win_height = Graphics.size_y () - border_padding in
  let x_per_pixel =  (end_x -. start_x) /. (float_of_int win_width) in
  let y_per_pixel =  (end_y -. start_y) /. (float_of_int win_height) in
  let line_start_x = 0 in
  let line_end_x = win_width in
  let line_start_y = ((intercept +. slope *. start_x) -. start_y) /. y_per_pixel in
  let line_end_y = ((intercept +. slope *. end_x) -. start_y) /. y_per_pixel in
  Printf.printf "start_y = %f, end_y = %f x_per_pixel: %f y_per_pixel: %f\n" line_start_y line_end_y x_per_pixel y_per_pixel ;
  Graphics.moveto line_start_x (int_of_float line_start_y) ;
  Graphics.lineto line_end_x (int_of_float line_end_y)
